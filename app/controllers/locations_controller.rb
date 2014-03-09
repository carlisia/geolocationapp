class LocationsController < ApplicationController
  helper_method :locations, :location, :marker_set, :origin_point, :distance_from_origin, :search_radius

  @@meters_in_mile = 1609.to_s

  # GET /locations
  # GET /location.xml
  def locations
    @_locations ||= Location.find(
      :all, 
      :select => "*, ST_Distance(latlon,'" + origin_point.to_s + "') / " + @@meters_in_mile + " as distance",
      :order  => "distance asc",
      :conditions => "ST_Distance(latlon,'" + origin_point.to_s + "') < " + search_radius.to_s + "*"+@@meters_in_mile
    )
  end
  
  def marker_set
    @_market_set = Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat location.latlon.latitude
      marker.lng location.latlon.longitude
      marker.title location.name
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
  
  def distance_from_origin
    @_distance = location.distance
  end

  def origin_point  
    params[:lat].present? ? lat = params[:lat] : lat = 33.1243208
    params[:lon].present? ? lon = params[:lon] : lon = -117.32582479999996
    @@origin_point = RGeo::Geographic.spherical_factory.point(lon,lat)
  end
  
  def search_radius
    radius_present? ? @_search_radius = params[:radius] : @_search_radius = 5
  end 
    
  private
  
  def radius_present?
    params[:radius].present?
  end

end