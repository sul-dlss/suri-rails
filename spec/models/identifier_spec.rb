# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Identifier, type: :model do
  describe '.create' do
    it 'enforces uniqueness of identifiers' do
      described_class.create(identifier: 'x')
      expect { described_class.create(identifier: 'x') }.to raise_exception ActiveRecord::RecordNotUnique
    end
  end

  describe '.mint' do
    it 'creates objects with unique identifiers' do
      expect { described_class.mint }.to change(described_class, :count).by(1)
    end

    it 'eventually gives up if it cannot generate a unique one' do
      described_class.create(identifier: 'x')
      allow(DruidMinter).to receive(:generate).and_return('x')
      expect(described_class.mint).to eq false
    end
  end
end
