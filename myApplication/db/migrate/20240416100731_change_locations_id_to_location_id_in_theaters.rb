class ChangeLocationsIdToLocationIdInTheaters < ActiveRecord::Migration[7.1]
  def change
    rename_column :theaters, :locations_id, :location_id
  end
end
