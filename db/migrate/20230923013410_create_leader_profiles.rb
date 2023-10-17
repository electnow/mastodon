# frozen_string_literal: true

class CreateLeaderProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :leader_profiles do |t|
      t.string :name
      t.attachment :avatar
      t.string :note, null: false, default: ''
      t.integer :type
      t.integer :level
      t.integer :time_in_office
      t.integer :rebellions
      t.integer :votes_attended
      t.integer :votes_possible
      t.integer :offices

      t.references :account, null: true, foreign_key: true
      t.references :parties, null: true, foreign_key: true

      t.timestamps
    end
  end
end
