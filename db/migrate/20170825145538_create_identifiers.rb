# frozen_string_literal: true

class CreateIdentifiers < ActiveRecord::Migration[5.1]
  def change
    create_table :identifiers do |t|
      t.string :identifier
      t.string :created_by

      t.timestamps
    end
    add_index :identifiers, :identifier, unique: true
  end
end
