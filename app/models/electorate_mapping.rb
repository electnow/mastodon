# frozen_string_literal: true

# == Schema Information
#
# Table name: electorate_mappings
#
#  id                       :bigint(8)        not null, primary key
#  geography_electorates_id :bigint(8)        not null
#  geography_states_id      :bigint(8)        not null
#  postal_code              :string
#  suburb                   :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class ElectorateMapping < ApplicationRecord
  belongs_to :geography_electorates, class_name: 'Geography::State'
  belongs_to :geography_states, class_name: 'Geography::Electorate'
end
