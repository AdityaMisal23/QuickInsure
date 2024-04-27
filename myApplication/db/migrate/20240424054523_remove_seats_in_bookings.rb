class RemoveSeatsInBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings , :seats
  end
end
