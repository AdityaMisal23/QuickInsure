class RemoveAddFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :add
  end
end
