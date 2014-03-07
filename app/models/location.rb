class Location < ActiveRecord::Base
  require 'csv'
  
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  
  def self.import(file)
    
    CSV.foreach(file.path, 
      headers: true, 
      :col_sep => "\t", 
      :header_converters => [:db_columns], 
      :converters => [:all, :blank_to_nil]) do |row|
      Location.create! row.to_hash
    end
  end
  
end


CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end
CSV::HeaderConverters[:db_columns] = lambda do |header|
  header && header.empty? ? nil : header.strip
end