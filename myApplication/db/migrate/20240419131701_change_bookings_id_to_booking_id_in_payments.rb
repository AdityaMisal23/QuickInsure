class ChangeBookingsIdToBookingIdInPayments < ActiveRecord::Migration[7.1]
  def change
    rename_column :payments, :bookings_id, :booking_id
  end
end
