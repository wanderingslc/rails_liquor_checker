class LocationsController < ApplicationController
  before_action :authenticate_admin!, only: [:new]
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper


  def index

  end

  def get_locations

    locations = Location.near([params[:lat], params[:lng]], 5)
    render json: locations.to_json
  end

  def new
    location_scope = Location.all

    # location_scope = location_scope.where("name ilike '%#{params[:filter]}%'")

    location_scope = location_scope.where(longitude: nil) if params[:missing_longitude] == "1"
    @locations = smart_listing_create(:locations, location_scope, partial: "locations/listing")
  end

  def import
    Location.import(params[:file])

    redirect_to locations_new_path, notice: 'Locations imported'
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :city, :state, :zip, :phone, :license, :latitude, :longitude, :pos )
  end

end
