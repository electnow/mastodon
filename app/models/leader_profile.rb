# frozen_string_literal: true

class LeaderProfile < ApplicationRecord
  belongs_to :account
  belongs_to :party

  enum type: { senator: 0, representative: 1 }
  enum level: { state: 0, electorate: 1, local: 2 }
end
