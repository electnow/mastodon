# frozen_string_literal: true

class Api::V2::ElectorateController < Api::BaseController
  skip_before_action :require_authenticated_user!

  def index
    @electorate = {}
    @census_data = {}
    @federal_hor_leaders = {}
    @federal_sen_leaders = {}
    @state_leaders = {}

    if @current_user.account.geography_electorates_id
      @electorate = Geography::Electorate.find(@current_user.account.geography_electorates_id).as_json

      @census_data = ElectorateCensusData.find_by(geography_electorates_id: @current_user.account.geography_electorates_id).as_json || {}

      @federal_hor_leaders = LeaderProfile.where(geography_electorate_id: [@current_user.account.geography_electorates_id, nil], parliament: LeaderProfile.parliaments[:federal], type: LeaderProfile.type[:hor]).as_json
      @federal_sen_leaders = LeaderProfile.where(geography_electorate_id: [@current_user.account.geography_electorates_id, nil], parliament: LeaderProfile.parliaments[:federal], type: LeaderProfile.type[:sen]).as_json
      @state_leaders = LeaderProfile.where(geography_electorate_id: [@current_user.account.geography_electorates_id, nil], parliament: LeaderProfile.parliaments[:state]).as_json
    end

    render json: { electorate: @electorate, census: @census_data, federalHorLeaders: @federal_hor_leaders, federalSenLeaders: @federal_sen_leaders, stateLeaders: @state_leaders }, status: 200
  end
end
