# frozen_string_literal: true

class CreateLeaderProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :leader_profiles do |t|
      t.string :name
      t.string :note
      t.integer :type
      t.integer :level
      t.integer :parliament
      t.references :geography_states, null: false, foreign_key: true
      t.references :geography_electorates, null: false, foreign_key: true
      t.references :parties, null: false, foreign_key: true
      t.references :account, null: true, foreign_key: true

      t.timestamps
    end
  end
end
