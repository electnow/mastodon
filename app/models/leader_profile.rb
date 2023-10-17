# frozen_string_literal: true

# == Schema Information
#
# Table name: leader_profiles
#
#  id                       :bigint(8)        not null, primary key
#  name                     :string
#  note                     :string
#  type                     :integer
#  level                    :integer
#  parliament               :integer
#  geography_states_id      :bigint(8)        not null
#  geography_electorates_id :bigint(8)        not null
#  parties_id               :bigint(8)        not null
#  account_id               :bigint(8)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class LeaderProfile < ApplicationRecord
  enum type: { senate: 0, house_of_representative: 1, house_of_assembly: 2 }

  enum level: { lower: 0, upper: 1 }

  enum parliament: { federal: 0, state: 1 }

  belongs_to :geography_states
  belongs_to :geography_electorates
  belongs_to :parties
  belongs_to :account
  has_one_attached :avatar
end
