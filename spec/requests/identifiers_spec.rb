# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Identifiers' do
  let!(:identifier) { Identifier.mint }

  describe 'GET #show' do
    context 'when identifier is minted' do
      it 'returns a success response' do
        get "/identifiers/#{identifier.identifier.to_param}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('identifier' => identifier.identifier)
      end
    end

    context 'when identifier is not found' do
      it 'returns a not found response' do
        get '/identifiers/bc123df4567'
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors'].first).to include(
          'status' => '404',
          'title' => 'Identifier not found: bc123df4567',
          'detail' => 'Identifier not found: bc123df4567'
        )
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Identifier' do
        expect do
          post '/identifiers'
        end.to change(Identifier, :count).by(1)
      end

      it 'renders a text response with the new identifier' do
        post '/identifiers'
        expect(response).to have_http_status(:created)
        expect(response.media_type).to eq('text/plain')
        expect(response.location).to eq(identifier_url(Identifier.last))
        expect(response.body).to eq Identifier.last.identifier
      end
    end

    context 'with a broken minter' do
      before do
        allow(Identifier).to receive(:mint).and_return(nil)
        allow(Honeybadger).to receive(:notify)
      end

      it 'renders an error' do
        post '/identifiers'
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['errors'].first).to include(
          'status' => '500',
          'title' => 'Unable to mint identifier',
          'detail' => 'NoMethodError: undefined method `identifier\' for nil:NilClass'
        )
        expect(Honeybadger).to have_received(:notify).once
      end
    end
  end

  describe 'POST #create (LEGACY ROUTE)' do
    context 'with valid params' do
      it 'creates a new Identifier' do
        expect do
          post '/suri2/namespaces/druid/identifiers'
        end.to change(Identifier, :count).by(1)
      end

      it 'renders a text response with the new identifier' do
        post '/suri2/namespaces/druid/identifiers'
        expect(response).to have_http_status(:created)
        expect(response.media_type).to eq('text/plain')
        expect(response.location).to eq(identifier_url(Identifier.last))
        expect(response.body).to eq Identifier.last.identifier
      end
    end

    context 'with a broken minter' do
      before do
        allow(Identifier).to receive(:mint).and_return(nil)
      end

      it 'renders an error' do
        post '/suri2/namespaces/druid/identifiers'
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['errors'].first).to include(
          'status' => '500',
          'title' => 'Unable to mint identifier',
          'detail' => 'NoMethodError: undefined method `identifier\' for nil:NilClass'
        )
      end
    end
  end
end
