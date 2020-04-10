# frozen_string_literal: true

class IdentifiersController < ApplicationController
  # GET /identifiers
  def index
    @identifiers = Identifier.all

    render json: @identifiers
  end

  # GET /identifiers/1
  def show
    @identifier = Identifier.find_by!(identifier: params[:id])
    render json: @identifier
  rescue ActiveRecord::RecordNotFound
    # NOTE: 404s are not Honeybadger-worthy
    render build_error("Identifier not found: #{params[:id]}", :not_found)
  end

  # POST /identifiers
  def create
    @identifier = Identifier.mint

    if @identifier
      render plain: @identifier.identifier, status: :created, location: @identifier
    else
      error_message = 'Unable to mint a druid'
      Honeybadger.notify(error_message)
      render build_error(error_message, :internal_server_error)
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  # JSON-API error response
  def build_error(msg, status)
    {
      json: {
        errors: [
          {
            "status": Rack::Utils::SYMBOL_TO_STATUS_CODE[status].to_s,
            "title": msg,
            "detail": msg
          }
        ]
      },
      content_type: 'application/vnd.api+json',
      status: status
    }
  end
  # rubocop:enable Metrics/MethodLength
end
