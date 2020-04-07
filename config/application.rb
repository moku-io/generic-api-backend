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

    config.i18n.available_locales = %i[it en]

    config.middleware.insert_before Warden::Manager, Rack::Cors do
      allow do
        origins %r{http://localhost(:\d+)?},
                %r{http://127\.0\.0\.1(:\d+)?},
                %r{http://10\.1\.60\.*(:\d+)?},
                %r{http(s)*://.*\.moku\.io},
                %r{http(s)*://.*\.netlify\.com},
                %r{http(s)*://.*\.ngrok\.io},
                %r{chrome-extension://.*}, # Allow Altair opened in the browser.
                %r{http(s)*://my-new-app\.production_server\.com} #TODO

        resource '*',
                 methods: %i[get post put patch delete options],
                 headers: :any, # ['Origin', 'X-Requested-With', 'Content-Type', 'Accept', 'Accept-Encoding', 'Authorization', 'Content-Disposition', 'Client-Version', 'Accept-Language'], # ALL headers must be specified
                 expose: %w[access-token expiry token-type uid client],
                 max_age: 600
      end
    end

    config.after_initialize do
      Apitome.configuration.mount_at = '/docs' # http://stackoverflow.com/a/34921974/930720
    end
  end
end
