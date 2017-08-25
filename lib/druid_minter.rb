# frozen_string_literal: true

# Mint druid-like strings
class DruidMinter
  TRUNCATED_ALPHA = 'bcdfghjkmnpqrstvwxyz'.split('').freeze

  # Generates a random ID
  # @return [String]
  def self.generate
    id_arr = []

    2.times { id_arr << TRUNCATED_ALPHA.sample }
    3.times { id_arr << rand(0..9) }
    2.times { id_arr << TRUNCATED_ALPHA.sample }
    4.times { id_arr << rand(0..9) }

    id_arr.join('')
  end
end
