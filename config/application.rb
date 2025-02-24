# frozen_string_literal: true

require_relative 'boot'

# require 'rails'
# Pick the frameworks you want:
# require 'active_model/railtie'
# require "active_job/railtie"
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require 'action_view/railtie'
# require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

class JSONAPIError < Committee::ValidationError
  def error_body
    {
      errors: [
        { status: id, detail: message }
      ]
    }
  end

  def render
    [
      status,
      { 'Content-Type' => 'application/vnd.api+json' },
      [JSON.generate(error_body)]
    ]
  end
end

module Suri
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Add timestamps to all loggers (both Rack-based ones and e.g. Sidekiq's)
    config.log_formatter = proc do |severity, datetime, _progname, msg|
      "[#{datetime.to_fs(:iso8601)}] [#{severity}] #{msg}\n"
    end

    # Stay out of business of validating gem-provided routes (e.g., OKComputer)
    accept_proc = proc { |request| request.path.include?('/identifiers') }
    config.middleware.use Committee::Middleware::RequestValidation, schema_path: 'openapi.yml',
                                                                    strict: true,
                                                                    strict_reference_validation: true,
                                                                    error_class: JSONAPIError,
                                                                    accept_request_filter: accept_proc,
                                                                    parse_response_by_content_type: false,
                                                                    parameter_overwrite_by_rails_rule: false

    # TODO: we can uncomment this once we can change all consumers of SURI to
    # expect a JSON array as a return type, rather than plain-text. The
    # Committee gem does not currently allow response validation for non-JSON
    # responses.
    #
    # config.middleware.use Committee::Middleware::ResponseValidation, schema_path: 'openapi.yml'

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
