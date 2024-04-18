class RemoveBookedSeatFromShows < ActiveRecord::Migration[7.1]
  def change
    remove_column :shows, :booked_seat
  end
end
