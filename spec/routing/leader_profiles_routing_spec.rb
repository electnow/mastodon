# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeaderProfilesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/leader_profiles').to route_to('leader_profiles#index')
    end

    it 'routes to #new' do
      expect(get: '/leader_profiles/new').to route_to('leader_profiles#new')
    end

    it 'routes to #show' do
      expect(get: '/leader_profiles/1').to route_to('leader_profiles#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/leader_profiles/1/edit').to route_to('leader_profiles#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/leader_profiles').to route_to('leader_profiles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/leader_profiles/1').to route_to('leader_profiles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/leader_profiles/1').to route_to('leader_profiles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/leader_profiles/1').to route_to('leader_profiles#destroy', id: '1')
    end
  end
end
