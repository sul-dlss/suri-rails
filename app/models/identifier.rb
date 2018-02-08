# frozen_string_literal: true

require 'druid_minter'

class Identifier < ApplicationRecord
  MAX_RETRIES = 10_000

  def to_param
    identifier
  end

  # Create a new Identifier with a guaranteed-unique identifier field
  #
  # @return [Identifier]
  # @return [false] if unable to mint an identifier after an appropriate amount of tries
  def self.mint(attributes = {})
    catch(:id) do
      MAX_RETRIES.times do
        id = DruidMinter.generate
        Identifier.transaction do
          next if Identifier.where(identifier: id).any?
          throw :id, Identifier.create!(attributes.merge(identifier: id))
        end

        return false
      end
    end
  end
end
