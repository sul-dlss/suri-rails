# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Identifier, type: :model do
  describe '.create' do
    it 'enforces uniqueness of identifiers' do
      described_class.create(identifier: 'x')
      expect { described_class.create(identifier: 'x') }.to raise_error ActiveRecord::RecordNotUnique
    end
  end

  describe '.mint' do
    it 'creates objects with unique identifiers' do
      expect { described_class.mint }.to change(described_class, :count).by(1)
    end

    context 'when minting runs out of retries' do
      let(:max_retries) { 5 }

      before do
        stub_const('Identifier::MAX_RETRIES', max_retries)
        allow(DruidMinter).to receive(:generate).and_return('x')
        described_class.create(identifier: 'x')
      end

      it 'eventually gives up if it cannot generate a unique one' do
        expect { described_class.mint }.to raise_error(
          RuntimeError,
          /Tried to mint a unique identifier #{max_retries} times and failed./
        )
      end
    end

    context 'when ActiveRecord exception is raised' do
      let(:error_class) { ActiveRecord::RecordInvalid }

      before do
        allow(described_class).to receive(:create!).and_raise(error_class)
      end

      it 'eventually gives up if it cannot generate a unique one' do
        expect { described_class.mint }.to raise_error(error_class)
      end
    end
  end
end
