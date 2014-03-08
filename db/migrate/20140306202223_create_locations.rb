class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :postal_code_name
      t.string :postal_code_suffix
      t.string :phone_number
      t.string :name
      t.point :latlon, :geographic => true
      t.integer :radius
      
      t.timestamps
    end
  end
end