class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :license
      t.string :license_type
      t.string :name
      t.jsonb :address
      t.string :phone
      t.float  :latitude
      t.float  :longitude
      t.boolean :beer, default: false
      t.boolean :wine, default: false
      t.boolean :liquor, default: false

      t.timestamps
    end
  end
end
