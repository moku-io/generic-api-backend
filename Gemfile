source 'https://rubygems.org'
ruby '2.5.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
gem 'rails-i18n', '~> 6.0.0'
# Use pg as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer', platforms: :ruby
gem 'webpacker'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveStorage variant
gem 'mini_magick'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'rspec-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'annotate'
  gem 'awesome_print', require: 'ap'
  gem 'brakeman'

  # Preview emails in browser
  gem 'letter_opener'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.4',        require: false
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
  # gem 'capybara', '>= 2.15', '< 4.0'
  # gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  gem 'rspec_api_documentation'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Optimizing N+1 queries
gem 'bullet', group: [:test, :development, :staging]

# Docs
gem 'apitome'

## Authentication and Authorization
# gem 'devise', github: 'plataformatec/devise', ref: '12fc5b76d89cf6e9c47289416fb24bf1a85f03da' # Just before version bump to 4.7 (incompatible with devise_token_auth) https://github.com/lynndylanhurley/devise_token_auth/issues/1331  -  https://github.com/lynndylanhurley/devise_token_auth/issues/1329
# gem 'devise-i18n'
# gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth'
gem 'devise', '~>4.7.0'
gem 'devise-i18n'
gem 'devise_token_auth', github: 'k4roshi/devise_token_auth'#, github: 'lynndylanhurley/devise_token_auth'

gem 'cancancan'
# gem 'rolify' # Handle roles.

## Active Admin and pagination
gem 'activeadmin'
gem 'kaminari-i18n'

## Utility
gem 'rack-cors'
gem 'rack-timeout', '~> 0.5'
gem 'versioncake'
gem 'whenever'
gem 'lograge'
# gem 'active_record_query_trace' # Trace who generates SQL queries.
# gem 'traco'   # Translations
# gem 'aws-sdk-s3', require: false

gem 'delayed_job_active_record'
gem 'delayed_job'
gem 'daemons' # Needed by delayed_job

# Airbrake is best to be loaded after all other gems - https://github.com/airbrake/airbrake/issues/826
gem 'airbrake', '8.3.2'
gem 'airbrake-ruby', '4.2.2'
