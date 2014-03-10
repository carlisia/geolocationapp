class RelativeLocations
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :lat, :lon, :radius, :format, :action, :controller, :search_radius
  
  #more validations are required for these values (format, etc):
  validates_presence_of :lat, :lon 
  
  METERS_IN_MILES = 1609.to_s

  def initialize(attributes = {})
    @attributes = attributes.each do |name, value|
      send("#{name}=", value)
    end
    list
  end
  
  def list
    @_relative_locations ||= Location.find(
      :all, 
      :select => "*, ST_Distance(latlon,'" + origin_point.to_s + "') / " + METERS_IN_MILES + " as distance",
      :order  => "distance asc",
      :conditions => "ST_Distance(latlon,'" + origin_point.to_s + "') < " + search_radius.to_s + "*" + METERS_IN_MILES
    )
  end
  
  def as_json(options = {})
    # optional k,v to add to the json response such as:
    # response code
    # url path to API documentation
  end
  
  #Below this point, not part of the API
  def origin_point  
    RGeo::Geographic.spherical_factory.point(lon,lat)
  end
  
  def persisted?
    false
  end  
  
  private
  
  def search_radius
    radius_present? ? @_search_radius = @attributes[:radius] : @_search_radius = 5
  end 
  
  def radius_present?
    @attributes[:radius].present?
  end
  
end