Airbrake.configure do |config|
  config.api_key = '02beb6911647332863601a3164e7f836'
  config.host    = 'errors.moku.io'
  config.port    = 80
  config.secure  = config.port == 443
end