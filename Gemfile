source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.2', '< 5.3'
gem 'rails-i18n', '~> 5.1.1'
# Use pg as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker'
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

  # Preview emails in browser
  gem 'letter_opener'

  # Use Capistrano for deployment
  gem 'capistrano', '3.4.0',        require: false
  gem 'capistrano-rvm',             require: false
  gem 'capistrano-rails',           require: false
  gem 'capistrano-bundler',         require: false
  gem 'capistrano3-nginx', '2.0.2', require: false
  gem 'capistrano3-puma', '1.1.0',  require: false
  gem 'capistrano3-delayed-job',    require: false
  gem 'capistrano-bundle_audit',    require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 2.15', '< 4.0'
  # gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  gem 'rspec-rails'
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
gem 'apitome', github: 'jejacks0n/apitome'

## Authentication and Authorization
gem 'devise'
gem 'devise-i18n'
gem 'devise_token_auth', '~> 0.1.43'
gem 'cancancan'

## Active Admin and pagination
gem 'activeadmin'
gem 'kaminari-i18n'

## Utility
gem 'rack-cors'
gem 'versioncake'
# gem 'aws-sdk-s3', require: false

gem 'airbrake', '7.3.0'
gem 'airbrake-ruby', '2.5.0'

gem 'delayed_job_active_record'
gem 'delayed_job'
gem 'daemons' # Needed by delayed_job
