# frozen_string_literal: true

class CreateElectorateCensusData < ActiveRecord::Migration[7.0]
  def change
    create_table :electorate_census_data do |t|
      t.references :geography_electorates, null: false, foreign_key: true
      t.integer :population
      t.integer :average_age
      t.integer :employment
      t.string :most_common_occupation
      t.string :most_common_education
      t.string :most_common_employment
      t.string :most_common_religion
      t.string :most_common_birth_country
      t.string :most_common_birth_country_parents
      t.integer :total_family_income
      t.string :mortgage_repayment
      t.string :rent_range
      t.string :language_proficiency

      t.timestamps
    end
  end
end
