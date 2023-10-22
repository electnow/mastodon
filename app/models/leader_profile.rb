# frozen_string_literal: true

# == Schema Information
#
# Table name: leader_profiles
#
#  id                      :bigint(8)        not null, primary key
#  name                    :string
#  note                    :string
#  type_of_leader          :integer
#  level                   :integer
#  parliament              :integer
#  geography_state_id      :bigint(8)        not null
#  geography_electorate_id :bigint(8)
#  party_id                :bigint(8)
#  account_id              :bigint(8)
#  avatar_file_name        :string
#  avatar_content_type     :string
#  avatar_file_size        :bigint(8)
#  avatar_updated_at       :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class LeaderProfile < ApplicationRecord
  enum type_of_leader: { senate: 0, house_of_representative: 1, house_of_assembly: 2 }

  enum level: { lower: 0, upper: 1 }

  enum parliament: { federal: 0, state: 1 }

  belongs_to :geography_state, class_name: 'Geography::State', optional: true
  belongs_to :geography_electorate, class_name: 'Geography::Electorate', optional: true
  belongs_to :party, optional: true
  belongs_to :account, optional: true

  include AccountAvatar
end
