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
set :delayed_job_queues, ['autoplak']
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
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
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

  # before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
  after  :finished,     'airbrake:deploy'
end

after 'deploy:published', 'restart' do
  invoke 'delayed_job:restart'
end