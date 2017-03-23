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
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec_api_documentation', github: 'zipmark/rspec_api_documentation'
  gem 'annotate'
  gem 'faker'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
end

# Optimizing N+1 queries
gem 'bullet', group: [:test, :development, :staging]

# Docs
gem 'apitome', github: 'modeset/apitome'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development do
  # Use Capistrano for deployment
  gem 'capistrano', '3.4.0',        require: false
  gem 'capistrano-rvm',             require: false
  gem 'capistrano-rails',           require: false
  gem 'capistrano-bundler',         require: false
  gem 'capistrano3-nginx', '2.0.2', require: false
  gem 'capistrano3-puma', '1.1.0',  require: false
  gem 'capistrano3-delayed-job',    require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'awesome_print', require: 'ap'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


###
## Authentication and Authorization
gem 'devise', github: 'plataformatec/devise'
gem 'devise-i18n'
gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth'
gem 'cancancan', '~> 1.16.0'


###
## Active Admin and pagination
gem 'activeadmin', github: 'activeadmin/activeadmin', branch: 'master'

gem 'formtastic', github: 'justinfrench/formtastic', branch: 'master'  # TEMP UNTIL RAILS5 GET STABLE!!!

gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'master'

gem 'kaminari', github: 'amatsuda/kaminari', branch: '0-17-stable'
gem 'kaminari-i18n'



###
## Utility
gem 'rack-cors'

gem 'whenever', github: 'javan/whenever'

gem 'airbrake', '5.6.1'
gem 'airbrake-ruby', '1.6.0'

gem 'figaro'

gem 'paperclip'
# gem 'aws-sdk', '>= 2.0'

gem 'delayed_job_active_record'
gem 'delayed_job', github: 'collectiveidea/delayed_job'  # TEMP rails 5
gem 'daemons' # Needed by delayed_job
