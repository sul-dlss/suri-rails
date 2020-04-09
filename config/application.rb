# frozen_string_literal: true

require_relative 'boot'

require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
# require 'action_view/railtie'
# require 'action_mailer/railtie'
# require 'active_job/railtie'
# require 'action_cable/engine'
# require 'action_mailbox/engine'
# require 'action_text/engine'
# require 'rails/test_unit/railtie'
# require 'sprockets/railtie'

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
    config.load_defaults 6.0

    # Stay out of business of validating gem-provided routes (e.g., OKComputer)
    accept_proc = proc { |request| request.path.include?('/identifiers') }
    config.middleware.use Committee::Middleware::RequestValidation, schema_path: 'openapi.yml',
                                                                    strict: true,
                                                                    error_class: JSONAPIError,
                                                                    accept_request_filter: accept_proc

    # TODO: we can uncomment this once we can change all consumers of SURI to
    # expect a JSON array as a return type, rather than plain-text. The
    # Committee gem does not currently allow response validation for non-JSON
    # responses.
    #
    # config.middleware.use Committee::Middleware::ResponseValidation, schema_path: 'openapi.yml'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
