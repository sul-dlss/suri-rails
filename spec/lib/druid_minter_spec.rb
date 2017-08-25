# frozen_string_literal: true

require 'spec_helper'
require 'druid_minter'

RSpec.describe DruidMinter do
  describe '.generate' do
    it 'mints random druids in the correct pattern' do
      expect(described_class.generate).to match(/[bcdfghjkmnpqrstvwxyz]{2}[0-9]{3}[bcdfghjkmnpqrstvwxyz]{2}[0-9]{4}/)
    end
  end
end
