require 'file_importer'

def seed_locations  
  file_path = Rails.root.join(*%w(db locations.tsv)).to_s
  FileImporter.import_file(file_path)
end


if Location.count >= 0
    seed_locations
else
  puts "Skipped Locations seed"
end