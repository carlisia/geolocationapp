class Location < ActiveRecord::Base
  include FileImporter

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def self.import(file)
    FileImporter.import_file(file.path)
  end

end