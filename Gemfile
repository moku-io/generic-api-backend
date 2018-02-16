source 'https://rubygems.org'
ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0', '< 5.1'
gem 'rack', '~> 2.0.1'
gem 'rails-i18n', '~> 5.0.1'

gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Action Cable dependencies for the Redis adapter
gem 'redis', '~> 3.0'

gem 'puma', group: [:production, :staging]


group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'rspec_api_documentation'
  gem 'annotate'
  gem 'faker'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
end

# Optimizing N+1 queries
gem 'bullet', group: [:test, :development, :staging]

# Docs
gem 'apitome', github: 'modeset/apitome'


group :development do
  # Use Capistrano for deployment
  gem 'capistrano', '3.4.0',        require: false
  gem 'capistrano-rvm',             require: false
  gem 'capistrano-rails',           require: false
  gem 'capistrano-bundler',         require: false
  gem 'capistrano3-nginx', '2.0.2', require: false
  gem 'capistrano3-puma', '1.1.0',  require: false
  gem 'capistrano3-delayed-job',    require: false
  gem 'capistrano-bundle_audit',    require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'awesome_print', require: 'ap'

  # Preview emails in browser
  gem 'letter_opener'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


###
## Authentication and Authorization
gem 'devise', '~> 4.2.1'
gem 'devise-i18n'
gem 'devise_token_auth', '~> 0.1.42'
gem 'cancancan', '~> 1.16.0'


###
## Active Admin and pagination
gem 'activeadmin'
gem 'kaminari-i18n'



###
## Utility
gem 'rack-cors'

gem 'versioncake'

gem 'airbrake', '6.1.0'
gem 'airbrake-ruby', '2.2.4'

gem 'figaro'

gem 'paperclip', '>= 5.2.0'
# gem 'aws-sdk', '>= 2.0'

gem 'delayed_job_active_record'
gem 'delayed_job'
gem 'daemons' # Needed by delayed_job
