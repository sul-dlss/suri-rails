# frozen_string_literal: true

class IdentifiersController < ApplicationController
  # GET /identifiers/1
  def show
    @identifier = Identifier.find_by!(identifier: params[:id])
    render json: @identifier
  rescue ActiveRecord::RecordNotFound
    # NOTE: 404s are not Honeybadger-worthy
    render build_error(title: "Identifier not found: #{params[:id]}", status: :not_found)
  end

  # POST /identifiers
  def create
    @identifier = Identifier.mint

    render plain: @identifier.identifier, status: :created, location: @identifier
  rescue StandardError => e
    error_prefix = 'Unable to mint identifier'
    error_message = "#{e.class}: #{e.message}"
    Honeybadger.notify("#{error_prefix}: #{error_message}")
    render build_error(title: error_prefix, detail: error_message, status: :internal_server_error)
  end

  private

  # rubocop:disable Metrics/MethodLength
  # JSON-API error response
  def build_error(title:, status:, detail: nil)
    {
      json: {
        errors: [
          {
            status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status].to_s,
            title:,
            detail: detail || title
          }
        ]
      },
      content_type: 'application/vnd.api+json',
      status:
    }
  end
  # rubocop:enable Metrics/MethodLength
end
