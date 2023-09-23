class CreateGeographyStates < ActiveRecord::Migration[7.0]
  def change
    create_table :geography_states do |t|
      t.string :name
      t.string :postal
      # t.st_point :region, geographic: true

      t.timestamps
    end
  end
end
