# frozen_string_literal: true

server 'sul-suri-qa.stanford.edu', user: 'suri', roles: %w[web app db]

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'production'
set :bundle_without, %w[deployment test development].join(' ')
