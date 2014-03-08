class Location < ActiveRecord::Base
  include FileImporter

  #For geo computations to assume a spherical earth:
  set_rgeo_factory_for_column(:latlon,
      RGeo::Geographic.spherical_factory(:srid => 4326))
      
  validates :name, presence: true
  validates :latlon, presence: true

  def self.import(file)
    FileImporter.import_file(file.path)
  end
 
end