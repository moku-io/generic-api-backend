# Manually load Figaro to get ENVs even if Rails is not initialized
require 'figaro'
Figaro.application = Figaro::Application.new(environment: ENV['RAILS_ENV'], path: "config/application.yml")
Figaro.load

# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever


every 1.day, :at => '4:15 am' do
  command "find \"#{File.expand_path('../../shared/db_backups')}/\" -type f -name \"#{ENV['db_name']}_*sql.gz\" -mtime +30 -exec rm {} \\;"
end

every 1.day, :at => '4:30 am' do
  command "sh -c 'PGPASSWORD=\"#{ENV['db_password']}\" pg_dump -h #{ENV['db_host']} -U #{ENV['db_username']} #{ENV['db_name']} > \"#{File.expand_path('../../shared/db_backups')}/#{ENV['db_name']}_`date +%F_%H%M`.sql\"'"
end