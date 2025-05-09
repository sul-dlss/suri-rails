# frozen_string_literal: true

server 'sul-suri-prod.stanford.edu', user: 'suri', roles: %w[web app db]

set :rails_env, 'production'
set :bundle_without, %w[deployment test development].join(' ')
