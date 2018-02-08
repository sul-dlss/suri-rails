# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::IdentifiersController, type: :controller do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # IdentifiersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      identifier = Identifier.mint
      get :index, params: {}, session: valid_session
      expect(response).to be_success
      expect(JSON.parse(response.body)).to include hash_including('identifier' => identifier.identifier)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      identifier = Identifier.mint
      get :show, params: { id: identifier.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Identifier' do
        expect do
          post :create, session: valid_session
        end.to change(Identifier, :count).by(1)
      end

      it 'renders a text response with the new identifier' do
        post :create, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('text/plain')
        expect(response.location).to eq(v2_identifier_url(Identifier.last))
        expect(response.body).to eq Identifier.last.identifier
      end
    end

    context 'with a broken minter' do
      it 'renders an errors' do
        allow(Identifier).to receive(:mint).and_return(false)
        post :create, session: valid_session
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
