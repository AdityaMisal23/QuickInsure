class AddSeatToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :seat, :integer, array: true, default: []
  end
end
