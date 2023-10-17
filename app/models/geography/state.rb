# frozen_string_literal: true

# == Schema Information
#
# Table name: geography_states
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Geography::State < ApplicationRecord
end
