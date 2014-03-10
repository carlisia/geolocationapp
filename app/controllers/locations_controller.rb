class LocationsController < ApplicationController 
  helper_method :locations, :location, :marker_set, :origin_point, :search_radius
  attr_accessor :locations, :search_radius, :origin_point
  
  def index
    @_relative_locations||= RelativeLocations.new(params)
    if @_relative_locations.valid?
      self.locations = @_relative_locations.list
      self.search_radius = @_relative_locations.search_radius
      self.origin_point = @_relative_locations.origin_point
      marker_set
    else
      # This badly needs some rescuing:
      redirect_to root_url, notice: "Something went wrong while trying to load locations."
    end
  end
  
  def import
    begin
      Location.import(params[:file])
      redirect_to locations_url, notice: "Location list imported."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format, or no file selected."
    end
  end
  
  private

  def marker_set
    @_market_set = Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat location.latlon.latitude
      marker.lng location.latlon.longitude
      marker.title location.name
    end   
  end

end