# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leader_profiles/edit' do
  let(:leader_profile) do
    LeaderProfile.create!
  end

  before do
    assign(:leader_profile, leader_profile)
  end

  it 'renders the edit leader_profile form' do
    render

    assert_select 'form[action=?][method=?]', leader_profile_path(leader_profile), 'post'
  end
end
