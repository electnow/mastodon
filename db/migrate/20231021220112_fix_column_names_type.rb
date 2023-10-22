# frozen_string_literal: true

class FixColumnNamesType < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  def change
    safety_assured { rename_column :leader_profiles, :type, :type_of_leader }
  end
end
