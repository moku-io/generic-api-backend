Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Limit log size for development (10MB maximum).
  config.logger = ActiveSupport::Logger.new(config.paths['log'].first, 1, 10 * 1024 * 1024)

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.default_url_options = { host: Rails.application.credentials.dig(Rails.env.to_sym, :url, :backend, :host) || 'localhost', protocol: Rails.application.credentials.dig(Rails.env.to_sym, :url, :backend, :protocol) || 'http' }

  config.action_mailer.smtp_settings = { address: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :address),
                                         port: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :port),
                                         domain: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :domain),
                                         user_name: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :username),
                                         password: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :password),
                                         authentication: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :authentication),
                                         enable_starttls_auto: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :starttls),
                                         openssl_verify_mode: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :ssl_verify),
                                         ssl: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :ssl) }

  ActionMailer::Base.default from: Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :action_mailer_from) || Rails.application.credentials.dig(Rails.env.to_sym, :smtp, :username)

  config.action_mailer.perform_deliveries = false

  # Bullet for optimizing N+1 queries
  config.after_initialize do
    Bullet.enable = true
    # Bullet.alert = true
    Bullet.bullet_logger = true
    # Bullet.console = true
    # Bullet.growl = true
    # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #                 :password => 'bullets_password_for_jabber',
    #                 :receiver => 'your_account@jabber.org',
    #                 :show_online_status => true }
    Bullet.rails_logger = true
    # Bullet.honeybadger = true
    # Bullet.bugsnag = true
    # Bullet.airbrake = true
    # Bullet.rollbar = true
    # Bullet.add_footer = true
    # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    # Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware' ]
    # Bullet.slack = { webhook_url: 'http://some.slack.url', channel: '#default', username: 'notifier' }
  end
end
