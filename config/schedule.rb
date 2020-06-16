# Manually load Rails to get env variables and constants
require File.expand_path(File.dirname(__FILE__) + '/environment')

# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever

if Rails.env.production?
  every 1.day, at: ['3:30 am', '1:00 pm'] do
    command "find \"#{File.expand_path('../../shared/db_backups')}/\" -type f -name \"#{Rails.application.credentials.dig(Rails.env.to_sym, :db, :name)}_*sql.gz\" -mtime +90 -exec rm {} \\;"
    command "sh -c 'PGPASSWORD=\"#{Rails.application.credentials.dig(Rails.env.to_sym, :db, :password)}\" pg_dump -Z 9 -h #{Rails.application.credentials.dig(Rails.env.to_sym, :db, :host)} -U #{Rails.application.credentials.dig(Rails.env.to_sym, :db, :username)} #{Rails.application.credentials.dig(Rails.env.to_sym, :db, :name)} > \"#{File.expand_path('../../shared/db_backups')}/#{Rails.application.credentials.dig(Rails.env.to_sym, :db, :name)}_`date +%F_%H%M`.sql.gz\"'"
  end
end

every 1.day, at: '4:00 am' do
  command 'sleep $[ ( $RANDOM / 1000 )  + 1 ]s; sudo letsencrypt renew; sleep 30; sudo service nginx reload'
end
