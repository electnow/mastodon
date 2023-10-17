# frozen_string_literal: true

class CreateLeaderProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :leader_profiles do |t|
      t.string :name
      t.string :note
      t.integer :type
      t.integer :level
      t.integer :parliament
      t.references :geography_state, null: false, foreign_key: { to_table: :geography_states }
      t.references :geography_electorate, null: true, foreign_key: { to_table: :geography_electorates }
      t.references :party, null: true, foreign_key: { to_table: :parties }
      t.references :account, null: true, foreign_key: { to_table: :accounts }

      t.attachment :avatar

      t.timestamps
    end
  end
end
