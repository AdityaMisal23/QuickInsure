class ChangeUsersToUserInTheaters < ActiveRecord::Migration[7.1]
  def change 
    rename_column :theaters, :users_id, :user_id
  end
end
