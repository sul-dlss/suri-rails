# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IdentifiersController do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/identifiers/1').to route_to('identifiers#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/identifiers').to route_to('identifiers#create')
    end
  end

  describe 'legacy routes' do
    it 'routes old identifier minting path' do
      expect(post: '/suri2/namespaces/druid/identifiers').to route_to('identifiers#create')
    end

    it 'routes old monitoring path' do
      expect(get: '/suri2/namespaces').to route_to('ok_computer/ok_computer#index')
    end
  end
end
