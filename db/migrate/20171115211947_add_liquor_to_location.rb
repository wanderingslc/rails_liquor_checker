class AddLiquorToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :liquor, :string, array: true, default: []
  end
end
