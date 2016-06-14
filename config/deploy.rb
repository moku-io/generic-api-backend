# config valid only for Capistrano 3.1
lock '3.4.0'

set :application,   "xxx_#{fetch(:stage)}"
set :repo_url, 'git@bitbucket.org:xxx/xxx.git'

# Default branch is 'develop'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "develop"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


# Don't change these unless you know what you're doing
set :user, 'deploy'
set :pty, true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, auth_methods: ["publickey"] }
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true         # Lower memory footprint. For 0 seconds deploy set it to false and invoke puma:phased-restart on deploy:restart
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to true if using ActiveRecord
set :nginx_root_path, '/etc/nginx'
set :nginx_sites_available, 'sites-available'
set :nginx_sites_enabled, 'sites-enabled'
set :nginx_template, "#{stage_config_path}/nginx.conf.erb"
set :app_server, true
set :app_server_socket, "#{shared_path}/tmp/sockets/puma.sock"

# Delayed jobs
set :delayed_job_workers, 1
set :delayed_job_queues, []
set :delayed_job_roles, [:app, :background]

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/application.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs,  %w{log tmp/pids tmp/sockets tmp/cache public/assets public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
      execute "mkdir #{shared_path}/tmp/log -p"
      execute "mkdir #{shared_path}/public/system -p"
      execute "mkdir #{shared_path}/db_backups -p"
      execute "mkdir #{shared_path}/ssl -p"
      execute "mkdir #{shared_path}/nginx_cache -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    before 'deploy:migrate', 'db_create'
    before 'deploy:restart', 'puma:start'

    on roles(:app) do
      invoke 'deploy'
      invoke 'deploy:lets_encrypt' if fetch(:nginx_use_ssl)
      invoke 'nginx:site:add'
      invoke 'nginx:site:enable'
      invoke 'puma:monit:config'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Clear cache'
  task :clear_cache do
    on roles(:app), in: :sequence, wait: 5 do
      execute "rm -R #{shared_path}/nginx_cache/*" rescue nil
    end
  end

  # Automatically create the DB https://github.com/capistrano/rails/pull/36
  desc 'Create Database'
  task :db_create do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end

  desc 'Init let\'s encrypt'
  task :lets_encrypt do
    on roles(:app) do
      # Run letsencrypt to generate the certs
      domains_list = fetch(:lets_encrypt_domains).split(' ').collect{|d| "-d #{d}"}.join(' ')
      execute "sudo letsencrypt certonly --webroot -w #{current_path}/public/ #{domains_list}"

      # Generate DH parameters for EDH ciphers
      execute "mkdir #{shared_path}/ssl -p"
      execute "openssl dhparam -out #{shared_path}/ssl/dhparams.pem 2048 2> /dev/null"
    end
  end

  desc 'Enable HTTPS'
  task :enable_https do
    on roles(:app) do
      set(:nginx_use_ssl, true)
      invoke 'deploy:lets_encrypt'
      invoke 'nginx:site:add'
    end
  end

  # before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
  after  :finished,     :clear_cache
  after  :finished,     'airbrake:deploy'
end

after 'deploy:published', 'restart' do  # Temp https://github.com/collectiveidea/delayed_job/issues/881
  invoke 'delayed_job:restart'
end