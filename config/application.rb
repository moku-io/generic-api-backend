require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GenericBackend
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.i18n.available_locales = [:it, :en]

    config.middleware.insert_before Warden::Manager, Rack::Cors do
      allow do
        origins /http:\/\/localhost(:\d+)?/,
                /http:\/\/127\.0\.0\.1(:\d+)?/,
                /http(s)*:\/\/.*\.my-new-app\.moku\.io/   # Accept subdomains and both http and https

        resource '*',
                 :methods => [:get, :post, :put, :patch, :delete, :options],
                 :headers => :any, #['Origin', 'X-Requested-With', 'Content-Type', 'Accept', 'Accept-Encoding', 'Authorization', 'Content-Disposition', 'Client-Version', 'Accept-Language'], # ALL headers must be specified
                 :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
                 :max_age => 600
      end
    end
  end
end
