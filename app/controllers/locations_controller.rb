class LocationsController < ApplicationController
  helper_method :locations, :location, :marker_set, :origin_point, :distance_from_origin

  @@meters_in_mile = 1609.to_s

  def locations point
    @_locations ||= Location.find(
      :all, 
      :select => "*, ST_Distance(latlon,'" + point.to_s + "') / " + @@meters_in_mile + " as distance",
      :order  => "distance asc"
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
  

  def origin_point  
    lat = 33.1243208
    lon = -117.32582479999996
    @@origin_point = RGeo::Geographic.spherical_factory.point(lon,lat)
  end
  
  def distance_from_origin
    @_distance = location.distance
  end

end


