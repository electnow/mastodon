# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leader_profiles/new' do
  before do
    assign(:leader_profile, LeaderProfile.new)
  end

  it 'renders new leader_profile form' do
    render

    assert_select 'form[action=?][method=?]', _leader_profiles_path, 'post'
  end
end
