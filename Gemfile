source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0', '>= 6.0.3.4'
# Use PostgreSQL as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.2', '>= 4.2.2' # Use Webpack to process JS and Yarn to manage front end dependencies
# Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
# gem 'jquery-rails' # jquery now in package.json
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 5' # turbolinks now in package.json
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.12', '>= 1.12.1'

gem 'bootstrap', '~> 4.5', '>= 4.5.3' # still needed for sprockets styles
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
gem 'devise', '~> 4.7', '>= 4.7.3' # For authentication
gem 'kaminari', '~> 1.2', '>= 1.2.1' # For pagination
gem 'pg_search', '~> 2.3', '>= 2.3.5' # For Postgres search feature
gem 'aws-sdk-s3', '~> 1.85' # For image uploading to S3 in production
gem 'faker', '~> 2.14'
gem 'omniauth-facebook', '~> 8.0'
gem 'active_storage_validations', '~> 0.9.0'

#gem 'airbrake'
#gem 'friendly_id'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

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
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'

  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'factory_bot_rails', '~> 6.1'

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
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
end

group :production do
  #gem 'google-analytics-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
