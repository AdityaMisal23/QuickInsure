class ChangeTheatersIdToTheaterIdInScreens < ActiveRecord::Migration[7.1]
  def change
    rename_column :screens, :theaters_id, :theater_id
  end
end
