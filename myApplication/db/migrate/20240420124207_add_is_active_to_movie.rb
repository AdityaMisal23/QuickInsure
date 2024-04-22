class AddIsActiveToMovie < ActiveRecord::Migration[7.1]
  def change
    add_column :movies , :is_active , :boolean
  end
end
