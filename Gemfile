# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootsnap' # Added in Rails 5.2 to speed up boot times
gem 'committee'
gem 'okcomputer'
gem 'pg'
gem 'puma', '~> 4.3' # Use Puma as the app server
gem 'rails', '~> 6.0.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'rubocop', '~> 0.81.0'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  # Use sqlite3 as the database for Active Record
  gem 'simplecov', '~> 0.17.1' # 0.18 breaks reporting https://github.com/codeclimate/test-reporter/issues/418
  gem 'sqlite3', '~> 1.4'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :deployment do
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'dlss-capistrano', require: false
end
