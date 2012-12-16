#source 'https://rubygems.org'
source 'http://mirror1.prod.rhcloud.com/mirror/ruby/'

# This version needs to be hardcoded for OpenShift compatability
gem 'thor', '= 0.14.6'
# This needs to be installed so we can run Rails console on OpenShift directly
gem 'minitest'

gem 'rails', '3.2.6'
gem 'mysql2'
gem 'pg'
gem 'sqlite3'
gem 'thin'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'

  gem 'therubyracer'
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
end

group :development do
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'jquery-rails'

gem 'haml-rails'
gem 'attr_encrypted', '~> 1.2.1'
gem 'rest-client', '~> 1.6.7'
gem 'icalendar', '~> 1.2.1'
gem 'activeadmin'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'newrelic_rpm'
gem 'girl_friday'
gem 'redis'
gem 'connection_pool'