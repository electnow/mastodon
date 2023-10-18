# frozen_string_literal: true

class LeaderProfilesController < ApplicationController
  before_action :set_leader_profile, only: %i(show edit update destroy)

  # GET /leader_profiles
  def index
    @leader_profiles = LeaderProfile.all
  end

  # GET /leader_profiles/1
  def show; end

  # GET /leader_profiles/new
  def new
    @leader_profile = LeaderProfile.new
  end

  # GET /leader_profiles/1/edit
  def edit; end

  # POST /leader_profiles
  def create
    @leader_profile = LeaderProfile.new(leader_profile_params)

    if @leader_profile.save
      redirect_to _leader_profiles_url, notice: I18n.t('Leader profile was successfully created.')
    else
      render :new, status: 422
    end
  end

  # PATCH/PUT /leader_profiles/1
  def update
    if @leader_profile.update(leader_profile_params)
      redirect_to _leader_profiles_url, notice: I18n.t('Leader profile was successfully updated.'), status: 303
    else
      render :edit, status: 422
    end
  end

  # DELETE /leader_profiles/1
  def destroy
    @leader_profile.destroy
    redirect_to _leader_profiles_url, notice: I18n.t('Leader profile was successfully destroyed.'), status: 303
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_leader_profile
    @leader_profile = LeaderProfile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def leader_profile_params
    params.fetch(:leader_profile, {})
  end
end
