# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Identifier, type: :model do
  describe '.create' do
    it 'enforces uniqueness of identifiers' do
      Identifier.create(identifier: 'x')
      expect { Identifier.create(identifier: 'x') }.to raise_exception ActiveRecord::RecordNotUnique
    end
  end
  describe '.mint' do
    it 'creates objects with unique identifiers' do
      expect { Identifier.mint }.to change { Identifier.count }.by(1)
    end

    it 'eventually gives up if it cannot generate a unique one' do
      Identifier.create(identifier: 'x')
      allow(DruidMinter).to receive(:generate).and_return('x')

      expect(Identifier.mint).to eq false
    end
  end
end
