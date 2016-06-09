# Manually load Rails to get env variables and constants
require File.expand_path(File.dirname(__FILE__) + "/environment")

# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever

every 1.day, :at => '4:15 am' do
  command "find \"#{File.expand_path('../../shared/db_backups')}/\" -type f -name \"#{ENV['db_name']}_*sql.gz\" -mtime +90 -exec rm {} \\;"
  command "sh -c 'PGPASSWORD=\"#{ENV['db_password']}\" pg_dump -h #{ENV['db_host']} -U #{ENV['db_username']} #{ENV['db_name']} | gzip > \"#{File.expand_path('../../shared/db_backups')}/#{ENV['db_name']}_`date +%F_%H%M`.sql.gz\"'"
end