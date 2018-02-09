# frozen_string_literal: true

class IdentifiersController < ApplicationController
  # GET /identifiers
  # GET /identifiers.json
  def index
    @identifiers = Identifier.all

    render json: @identifiers
  end

  # GET /identifiers/1
  # GET /identifiers/1.json
  def show
    @identifier = Identifier.find_by(identifier: params[:id])
    render json: @identifier
  end

  # POST /identifiers
  # POST /identifiers.json
  def create
    @identifier = Identifier.mint

    if @identifier
      render plain: @identifier.identifier, status: :created, location: @identifier
    else
      render json: { error: 'Unable to mint a druid' }, status: :internal_server_error
    end
  end
end
