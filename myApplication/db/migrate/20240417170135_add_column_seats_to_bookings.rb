class AddColumnSeatsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings ,:seats ,:json
  end
end
