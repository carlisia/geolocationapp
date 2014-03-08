class LocationsController < ApplicationController
  helper_method :locations, :location, :marker_set, :origin_point, :distance_from_origin


  def locations
    @_locations ||= Location.order("ST_Distance(latlon,'" + origin_point.to_s + "') ASC")                                                   
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
  

  def origin_point  
    lat = 33.1243208
    lon = -117.32582479999996
    @_origin_point = RGeo::Geographic.spherical_factory.point(lon,lat)
  end
  
  def distance_from_origin location
    @_distance = location.distance
  end
end


