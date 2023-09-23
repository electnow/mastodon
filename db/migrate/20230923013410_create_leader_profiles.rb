class CreateLeaderProfiles < ActiveRecord::Migration[7.0]

  def change
    create_table :leader_profiles do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :type
      t.integer :level
      t.references :parties, null: true, foreign_key: true
      t.integer :time_in_office
      t.integer :rebellions
      t.integer :votes_attended
      t.integer :votes_possible
      t.integer :offices

      t.timestamps
    end
  end
end
