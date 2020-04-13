# frozen_string_literal: true

server 'sul-suri-stage.stanford.edu', user: 'suri', roles: %w[web app db]

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'production'
set :bundle_without, %w[deployment test development].join(' ')
# See https://github.com/honeybadger-io/honeybadger-ruby/issues/129 &
# https://github.com/honeybadger-io/honeybadger-ruby/blob/7eea24a47d44aed663e315be970e501b7cf092fc/vendor/capistrano-honeybadger/README.md
set :honeybadger_server, primary(:app)
