# config valid only for Capistrano 3.1
lock '3.4.0'
set :rvm_ruby_version, '2.3.3'

set :application,   "xxxx_#{fetch(:stage)}"
set :repo_url, 'git@bitbucket.org:xxxx/xxxx.git'

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
set :linked_dirs,  %w{log tmp/pids tmp/sockets tmp/cache public/assets public/system public/.well-known doc/api}

set :generate_docs, ask('Do you want to generate docs and upload? [Yn]', 'Y')


namespace :deploy do
  desc 'Create required directories'
  task :make_dirs do
    on roles(:app) do
      execute :mkdir, "#{shared_path}/tmp/sockets -p"
      execute :mkdir, "#{shared_path}/tmp/pids -p"
      execute :mkdir, "#{shared_path}/tmp/log -p"
      execute :mkdir, "#{shared_path}/public/system -p"
      execute :mkdir, "#{shared_path}/doc/api -p"
      execute :mkdir, "#{shared_path}/public/.well-known -p"
      execute :mkdir, "#{shared_path}/db_backups -p"
      execute :mkdir, "#{shared_path}/ssl -p"
      execute :mkdir, "#{shared_path}/nginx_cache -p"
    end
  end

  desc 'Initial Deploy'
  task :initial do
    before 'deploy:starting', 'deploy:make_dirs'
    before 'deploy:updated', 'db_create'
    # before 'deploy:restart', 'puma:start'

    on roles(:app) do
      set(:nginx_use_ssl, false)
      invoke 'deploy'
      invoke 'deploy:lets_encrypt' if fetch(:nginx_use_ssl)
      invoke 'nginx:site:add'
      invoke 'nginx:site:enable'
      invoke 'puma:monit:config'
      invoke 'deploy:my_delayed_job:monit:config'
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
      execute "rm -R #{shared_path}/nginx_cache/*" rescue nil  #TODO execute :rm, '-R' funziona?
    end
  end

  desc 'Update documentation'
  task :update_docs do
    answer = fetch(:generate_docs)
    if answer.strip.downcase == 'y'
      # Generate docs (locally)
      unless system('RAILS_ENV=test rake db:migrate docs:generate:ordered')
        raise 'Error while generating docs.'
      end

      on roles(:app), in: :sequence, wait: 5 do
        upload! 'doc/api', shared_path.join('doc'), recursive: true
      end
    end
  end

  # Automatically create the DB https://github.com/capistrano/rails/pull/36
  desc 'Create Database'
  task :db_create do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create' rescue nil
        end
      end
    end
  end

  desc 'Init let\'s encrypt'
  task :lets_encrypt do
    on roles(:app) do
      # Run letsencrypt to generate the certs
      # Prerequisites:
      #    sudo apt-get install letsencrypt
      domains_list = fetch(:lets_encrypt_domains).split(' ').collect{|d| "-d #{d}"}.join(' ')
      execute "sudo letsencrypt certonly --webroot -w #{current_path}/public/ #{domains_list} --email #{fetch(:lets_encrypt_email)} --agree-tos"

      # Generate DH parameters for EDH ciphers
      execute :mkdir, "#{shared_path}/ssl -p"
      execute "openssl dhparam -out #{shared_path}/ssl/dhparams.pem 2048 2> /dev/null"
    end
  end

  desc 'Enable HTTPS'
  task :enable_https do
    on roles(:app) do
      set(:nginx_use_ssl, true)
      invoke 'deploy:lets_encrypt'
      invoke 'nginx:site:add'
      invoke 'nginx:site:enable'
      invoke 'nginx:reload'
    end
  end

  namespace :my_delayed_job do
    # Defining my own monit setup, since capistrano-delayed_job need runit and doen't specifies the ruby version in the delayed_job conf.
    namespace :monit do
      desc 'Configure monit for delayed_job'
      task :config do
        on roles(:app), in: :sequence, wait: 5 do
          within fetch(:sites_available) do
            config_file = File.expand_path('../deploy/delayed_job_monit.conf.erb', __FILE__)
            config = ERB.new(File.read(config_file)).result(binding)

            upload! StringIO.new(config), '/tmp/delayed_job.conf'
            arguments = :sudo, :mv, '/tmp/delayed_job.conf', "/etc/monit/conf.d/delayed_job_#{fetch(:application)}.conf"
            execute *arguments
          end
        end
      end
    end
  end

  # before :starting,     :check_revision
  before :starting,     :update_docs
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
  after  :finished,     :clear_cache
  # after  :finished,     'airbrake:deploy'
end

after 'deploy:published', 'restart' do
  invoke 'delayed_job:restart'
end