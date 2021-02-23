
Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout, service_timeout: 30
Rack::Timeout::Logger.level = Logger::ERROR
