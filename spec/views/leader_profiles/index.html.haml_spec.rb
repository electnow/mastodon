# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'leader_profiles/index' do
  before do
    assign(:leader_profiles, [
             LeaderProfile.create!,
             LeaderProfile.create!,
           ])
  end

  it 'renders a list of leader_profiles'
  # it 'renders a list of leader_profiles' do
  # render
  # Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  # end
end
