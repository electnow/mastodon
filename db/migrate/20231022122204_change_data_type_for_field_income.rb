class ChangeDataTypeForFieldIncome < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  def up
    safety_assured { change_column(:electorate_census_data, :total_family_income, :string) }
  end

  def down
    safety_assured { change_column(:electorate_census_data, :total_family_income, :integer) }
  end
end
