Airbrake.configure do |config|
  config.api_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.host    = 'errors.moku.io'
  config.port    = 80
  config.secure  = config.port == 443
end