# frozen_string_literal: true

# == Schema Information
#
# Table name: geography_electorates
#
#  id                 :bigint(8)        not null, primary key
#  name               :string
#  postal             :string
#  geography_state_id :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Geography::Electorate < ApplicationRecord
end
