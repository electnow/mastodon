# frozen_string_literal: true

class CreateGeographyStates < ActiveRecord::Migration[7.0]
  def change
    create_table :geography_states do |t|
      t.string :name
      t.string :code, unique: true

      t.timestamps
    end
    add_index :geography_states, :code, unique: true
  end
end
