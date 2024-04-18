class RemoveShowIdFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :show_id
  end
end
