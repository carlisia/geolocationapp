class RelativeLocations
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :lat, :lon, :radius, :format, :action, :controller, :search_radius

  #more validations are required for these values (format, lenght, etc):
  validates_presence_of :lat, :lon 
  
  METERS_IN_MILES = 1609.to_s

  def initialize(attributes = {})
    @attributes = attributes
    ensure_params_have_values
    @attributes.each do |name, value|
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
  
  def origin_point
    RGeo::Geographic.spherical_factory.point(@attributes[:lon],@attributes[:lat])
  end

  # I decided to set a default value if params are empty. The solution could be more elegant.
  def ensure_params_have_values
    @attributes[:lat] = 33.1243208 unless @attributes[:lat].present? 
    @attributes[:lon] = -117.32582479999996 unless @attributes[:lon].present? 
    @attributes[:radius].present? ? @_search_radius = @attributes[:radius] : self.set_radius
  end

  def persisted?
    false
  end  
  
  def search_radius
    @_search_radius
  end
  
  def set_radius
     @_search_radius, @attributes[:radius]  = 5, 5
  end

end