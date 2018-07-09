require 'airbrake/delayed_job'

Airbrake.configure do |config|
  config.environment = Rails.env
  config.ignore_environments = %w(development test)

  config.project_id  = 1
  config.project_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.host        = 'https://errors.moku.io'
end

# Example of a filtered exception.
# Airbrake.add_filter do |notice|
#   # The library supports nested exceptions, so one notice can carry several
#   # exceptions.
#   if notice[:errors].any? { |error| error[:type] == 'Net::ReadTimeout' }
#     notice.ignore!
#   end
# end