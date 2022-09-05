source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '2.7.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1', '>= 6.1.6.1'
# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 1.4', '>= 1.4.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# Use Webpack to process JS and Yarn to manage front end dependencies
gem 'webpacker', '~> 5.4', '>= 5.4.3'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 5' # turbolinks now in package.json
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.12', '>= 1.12.2'

# Use Bootstrap gem for styling, still needed for Sprockets styles
gem 'bootstrap', '~> 4.6', '>= 4.6.1'
# Font Awesome provides icons
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
# Use Devise for authentication and user registration
gem 'devise', '~> 4.8', '>= 4.8.1'
# Use Kaminari For pagination
gem 'kaminari', '~> 1.2', '>= 1.2.2'
# Use PG Search For Postgres search feature
gem 'pg_search', '~> 2.3', '>= 2.3.6'
# For image uploading to S3 in production
gem 'aws-sdk-s3', '~> 1.114'
# Use Faker to generate example data
gem 'faker', '~> 2.23'
# Set up OAuth registration and authentication via Facebook
gem 'omniauth-facebook', '~> 9.0'
# Add validations for Active Storage images
gem 'active_storage_validations', '~> 0.9.8'

#gem 'airbrake'
#gem 'friendly_id'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  # Use RSpec for testing
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
   # Use Factory Bot to generate model instances for tests
  gem 'factory_bot_rails', '~> 6.2'
  # Use a .env file to store environment variables for development
  gem 'dotenv-rails'
  #gem 'better_errors'
  #gem 'sprockets_better_errors'
  #gem 'binding_of_caller'
  #gem 'simplecov'
  # gem 'pry'
  #gem 'rack_session_access'

  #gem 'capybara-webkit'
  #gem 'guard-rspec', require: false  
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Use Annotate to print out schema on model files
  gem 'annotate'
  # Replace the standard Rails error page
  gem 'better_errors'
  # Binding of Caller will open interactive REPL when application crashes
  gem 'binding_of_caller'
  # Use Pry instead of IRB for Rails console
  gem 'pry-rails'
  # Automatically run RSpec tests
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
end

group :test do
  # Use one-line matchers for RSpec testing
  gem 'shoulda-matchers', '~> 5.1'
  # Bring back assigns and assert_template for controller testing
  gem 'rails-controller-testing'
  # Clean databases for testing
  gem 'database_cleaner-active_record', '~> 2.0', '>= 2.0.1'
  # Launch applications with Capybara and RSpec
  gem 'launchy', '~> 2.5'
  
end

# group :production do
#   gem 'google-analytics-rails'
# end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
