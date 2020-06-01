# frozen_string_literal: true

require 'druid_minter'

class Identifier < ApplicationRecord
  MAX_RETRIES = 10_000

  # @param attributes [Hash] key/value pairs to pass into `Identifier#create!`
  # @return [Identifier] return an identifier instance if no errors
  # @raise [RuntimeError,ActiveRecord::ActiveRecordError] if minting encounters errors
  def self.mint(attributes = {})
    MAX_RETRIES.times do
      id = DruidMinter.generate
      Identifier.transaction do
        next if Identifier.where(identifier: id).any?

        return Identifier.create!(attributes.merge(identifier: id))
      end
    end

    raise "Tried to mint a unique identifier #{MAX_RETRIES} times and failed."
  end
end
