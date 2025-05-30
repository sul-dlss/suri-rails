# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootsnap' # Added in Rails 5.2 to speed up boot times
gem 'committee'
gem 'honeybadger'
gem 'okcomputer'
gem 'pg'
gem 'puma' # Use Puma as the app server
gem 'rails', '~> 8.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rubocop', '~> 1.23'
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
  gem 'simplecov'
end

group :deployment do
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', require: false
  gem 'dlss-capistrano', require: false
end
