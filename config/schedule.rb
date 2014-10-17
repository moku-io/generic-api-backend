# Manually load Figaro to get ENVs even if Rails is not initialized
require 'figaro'
Figaro.application = Figaro::Application.new(environment: ENV['RAILS_ENV'], path: "config/application.yml")
Figaro.load

# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever


every 1.day, :at => '5:00 am' do
  command "sh -c 'PGPASSWORD=\"#{ENV['db_password']}\" pg_dump -h #{ENV['db_host']} -U #{ENV['db_username']} #{ENV['db_name']} > \"#{File.expand_path('../../shared/db_backups')}/#{ENV['db_name']}_`date +%F_%H%M`.sql\"'"
end