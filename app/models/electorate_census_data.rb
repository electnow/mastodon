# frozen_string_literal: true

# == Schema Information
#
# Table name: electorate_census_data
#
#  id                                :bigint(8)        not null, primary key
#  geography_electorates_id          :bigint(8)        not null
#  population                        :integer
#  average_age                       :integer
#  employment                        :integer
#  most_common_occupation            :string
#  most_common_education             :string
#  most_common_employment            :string
#  most_common_religion              :string
#  most_common_birth_country         :string
#  most_common_birth_country_parents :string
#  total_family_income               :integer
#  mortgage_repayment                :string
#  rent_range                        :string
#  language_proficiency              :string
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
class ElectorateCensusData < ApplicationRecord
  belongs_to :geography_electorates, class_name: 'Geography::Electorate'
end
