class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :postal_code_name
      t.string :postal_code_suffix
      t.string :phone_number
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.integer :radius
      
      t.timestamps
    end
  end
end