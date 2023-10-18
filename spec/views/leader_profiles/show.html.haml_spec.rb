# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leader_profiles/show' do
  before do
    assign(:leader_profile, LeaderProfile.create!)
  end

  it 'renders attributes in <p>'
  # it 'renders attributes in <p>' do
  #   render
  # end
end
