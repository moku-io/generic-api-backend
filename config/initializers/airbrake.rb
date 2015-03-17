Airbrake.configure do |config|
  config.api_key = 'f79efa94c209cbe1ef0602c79beb5771'
  config.host    = 'errors.moku.io'
  config.port    = 80
  config.secure  = config.port == 443
end