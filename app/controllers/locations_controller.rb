class LocationsController < ApplicationController
  before_action :authenticate_admin!, only: [:new]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  def index
  end

  def new
  end

  def import
    Location.import(params[:file])

    redirect_to root_url, notice: 'Locations imported'
  end


end
