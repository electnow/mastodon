class LeaderProfile < ApplicationRecord
  belongs_to :account
  belongs_to :party

  enum type: [ :senator, :representative ]
  enum level: [ :state, :electorate, :local ]
end
