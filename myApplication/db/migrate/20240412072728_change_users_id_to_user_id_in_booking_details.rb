class ChangeUsersIdToUserIdInBookingDetails < ActiveRecord::Migration[7.1]
  def change
    rename_column :booking_details, :users_id, :user_id
  end
end
