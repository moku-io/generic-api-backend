source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
git_source(:bitbucket) { |repo| "https://bitbucket.org/#{repo}.git" }

ruby '2.5.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
gem 'rails-i18n', '~> 6.0.0'
# Use pg as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'  #TODO: OLD PUMA
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'mini_magick'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'faker'
  gem 'isolator'
  gem 'attractor'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
  gem 'awesome_print', require: 'ap'
  gem 'brakeman'

  # Preview emails in browser
  gem 'letter_opener'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.4.0',     require: false
  gem 'capistrano-rvm',             require: false
  gem 'capistrano-rails',           require: false
  gem 'capistrano-bundler',         require: false
  gem 'capistrano3-nginx', '2.0.2', require: false
  gem 'capistrano3-puma', '1.1.0',  require: false
  gem 'capistrano3-delayed-job',    require: false
  gem 'capistrano-bundle_audit',    require: false
  gem 'rb-readline'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  # gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Docs
gem 'rspec_api_documentation'
gem 'apitome'

## Authentication and Authorization
gem 'devise', '~> 4.7.0'
gem 'devise-i18n'
gem 'devise_token_auth', '~> 1.1'
gem 'cancancan'
# gem 'rolify' # Handle roles.
# gem 'koala'  # If you need FB auth.

## Active Admin and pagination
gem 'activeadmin'
gem 'arctic_admin'
gem 'kaminari-i18n'

## Utility
gem 'active_storage_validations'
gem 'bullet', group: [:test, :development, :staging]
gem 'rack-cors'
gem 'rack-timeout', '~> 0.5'
gem 'whenever'
gem 'lograge'
gem 'aws-sdk-s3'
# gem 'active_record_query_trace' # Trace who generates SQL queries.
# gem 'traco'   # Translations

gem 'delayed_job_active_record'
gem 'delayed_job'
gem 'daemons' # Needed by delayed_job

# Airbrake is best to be loaded after all other gems - https://github.com/airbrake/airbrake/issues/826
gem 'airbrake', '8.3.2'
gem 'airbrake-ruby', '4.2.2'
