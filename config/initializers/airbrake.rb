require 'airbrake/delayed_job'

Airbrake.configure do |config|
  config.environment = Rails.env
  config.ignore_environments = %w(development test)

  config.project_id  = 1
  config.project_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.host        = 'https://errors.moku.io'
end
