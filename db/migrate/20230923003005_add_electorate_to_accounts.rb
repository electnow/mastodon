# frozen_string_literal: true

class AddElectorateToAccounts < ActiveRecord::Migration[7.0]
  def up
    safety_assured do
      execute <<-SQL.squish
        ALTER TABLE accounts
        ADD electorate_id INTEGER NULL,
        ADD CONSTRAINT fk_accounts_electorates
        FOREIGN KEY (electorate_id)
        REFERENCES geography_electorates(id)
        ON DELETE CASCADE;
      SQL
    end
  end

  def down
    safety_assured do
      execute <<-SQL.squish
        ALTER TABLE accounts
        DROP CONSTRAINT IF EXISTS fk_accounts_electorates;
        ALTER TABLE accounts DROP electorate_id;
      SQL
    end
  end
end
