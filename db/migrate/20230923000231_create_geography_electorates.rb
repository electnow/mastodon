# frozen_string_literal: true

class CreateGeographyElectorates < ActiveRecord::Migration[7.0]
  def change
    create_table :geography_electorates do |t|
      t.string :name
      t.string :postal
      # t.st_point :region, geographic: true

      t.references :geography_state, foreign_key: { to_table: :geography_states }

      t.timestamps
    end
  end
end
