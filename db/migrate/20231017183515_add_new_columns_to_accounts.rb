# frozen_string_literal: true

class AddNewColumnsToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :postal_code, :string, null: true, default: nil
    add_column :accounts, :suburb, :string, null: true, default: nil
  end
end
