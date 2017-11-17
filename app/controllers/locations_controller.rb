class LocationsController < ApplicationController
  before_action :authenticate_admin!, only: [:new]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  def index
  end

  def new
    @locations = smart_listing_create(:locations, Location.all, partial: "locations/listing")
  end

  def import
    Location.import(params[:file])

    redirect_to locations_new_path, notice: 'Locations imported'
  end


end
