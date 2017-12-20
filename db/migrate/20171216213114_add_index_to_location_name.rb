class AddIndexToLocationName < ActiveRecord::Migration[5.1]
  def change
    add_index :locations, :latitude
    add_index :locations, :longitude
    add_index :locations, :beer
    add_index :locations, :wine
    add_index :locations, :liquor
  end
end
