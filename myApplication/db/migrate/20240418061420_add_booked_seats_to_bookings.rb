class AddBookedSeatsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :seats, :integer, array: true, default: []
  end
end
