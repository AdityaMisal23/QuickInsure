class ChangeTableNameFromBookingDetailsToBookings < ActiveRecord::Migration[7.1]
  def change
    rename_table :booking_details, :bookings
  end
end
