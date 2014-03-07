require 'csv'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end
CSV::HeaderConverters[:db_columns] = lambda do |header|
  header && header.empty? ? nil : header.strip
end

def import_file  
  file_path = Rails.root.join(*%w(db locations.tsv)).to_s
  CSV.foreach(file_path, 
    headers: true, 
    :col_sep => "\t", 
    :header_converters => [:db_columns], 
    :converters => [:all, :blank_to_nil]) do |row|
    Location.create! row.to_hash
  end
  
end

if Location.count == 0
    import_file
else
  puts "Skipped Locations seed"
end