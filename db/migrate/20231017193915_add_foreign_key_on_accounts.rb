# frozen_string_literal: true

class AddForeignKeyOnAccounts < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  def change
    safety_assured { add_reference :accounts, :geography_electorates, foreign_key: { on_delete: :cascade }, index: { algorithm: :concurrently } }
  end
end
