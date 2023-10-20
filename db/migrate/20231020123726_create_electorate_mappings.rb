# frozen_string_literal: true

class CreateElectorateMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :electorate_mappings do |t|
      t.references :geography_electorates, null: false, foreign_key: true
      t.references :geography_states, null: false, foreign_key: true
      t.string :postal_code
      t.string :suburb

      t.timestamps
    end
  end
end
