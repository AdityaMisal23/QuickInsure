class ChangeScreenIdToShowId < ActiveRecord::Migration[7.1]
  def change
    rename_column :bookings, :screen_id, :show_id
  end
end
