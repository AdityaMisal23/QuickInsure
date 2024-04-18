class RemoveSeatFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings , :seat
  end
end
