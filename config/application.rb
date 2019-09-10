require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GenericBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 6.0
    config.load_defaults 5.2
    config.autoloader = :classic

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.active_job.queue_adapter = :delayed_job

    config.i18n.available_locales = [:it, :en]

    config.middleware.insert_before Warden::Manager, Rack::Cors do
      allow do
        origins /http:\/\/localhost(:\d+)?/,
                /http:\/\/127\.0\.0\.1(:\d+)?/,
                /http:\/\/10\.1\.60\.*(:\d+)?/,
                /http(s)*:\/\/.*\.moku\.io/,
                /http(s)*:\/\/.*\..*\.moku\.io/,
                /http(s)*:\/\/.*\.ngrok\.io/,
                /http(s)*:\/\/.*\.my-new-app\.production_server\.com/   # Accept subdomains and both http and https

        resource '*',
                 methods: [:get, :post, :put, :patch, :delete, :options],
                 headers: :any, #['Origin', 'X-Requested-With', 'Content-Type', 'Accept', 'Accept-Encoding', 'Authorization', 'Content-Disposition', 'Client-Version', 'Accept-Language'], # ALL headers must be specified
                 expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
                 max_age: 600
      end
    end

    config.after_initialize do
      Apitome.configuration.mount_at = '/docs'  # http://stackoverflow.com/a/34921974/930720
    end
  end
end
