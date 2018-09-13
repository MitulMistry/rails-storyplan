source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '2.4.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 1.1', '>= 1.1.3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'bootstrap', '4.0.0.alpha6' # Bootstrap 4 gem
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
gem 'font-awesome-rails'
gem 'devise', '~> 4.5' # For authentication
gem 'kaminari', '~> 1.1', '>= 1.1.1' # For pagination
gem 'paperclip', '~> 6.1' # For image attachments
gem 'pg_search', '~> 2.1', '>= 2.1.2' # For Postgres search feature
gem 'aws-sdk', '~> 3.0', '>= 3.0.1' # For image uploading to S3 in production
gem 'faker'
gem 'omniauth-facebook', '~> 5.0'

gem 'bower-rails' # Use Bower to manage front end dependencies

#gem 'airbrake'
#gem 'friendly_id'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'

  gem 'rspec-rails'
  gem 'factory_girl_rails'

  #gem 'better_errors'
  #gem 'sprockets_better_errors'
  #gem 'binding_of_caller'
  #gem 'simplecov'
  gem 'pry'
  #gem 'rack_session_access'

  #gem 'capybara-webkit'
  #gem 'guard-rspec', require: false

  gem 'dotenv-rails'
end

group :test do
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers'
end

group :production do
  #gem 'google-analytics-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
