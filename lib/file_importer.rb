module FileImporter
  require 'csv'

  def self.import_file(file_path)  
    CSV.foreach(file_path, 
      headers: true, 
      :col_sep => "\t", 
      :header_converters => [:db_columns], 
      :converters => [:all, :blank_to_nil]) do |row|
      location_attributes = row.to_hash
      latlon = location_attributes.slice(:latitude, :longitude)
      #A point takes the longitude as the first param
      point = "POINT(#{latlon[:longitude]} #{latlon[:latitude]})"
      location_attributes[:latlon] = point
      Location.create! location_attributes.except(:latitude, :longitude)
    end
  end

  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end
  CSV::HeaderConverters[:db_columns] = lambda do |header|
    header && header.empty? ? nil : header.strip.to_sym
  end

end