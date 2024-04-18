class AddBookedSeatsToShows < ActiveRecord::Migration[7.1]
  def change
    add_column :shows, :booked_seat, :integer, array: true, default: []
  end
end
