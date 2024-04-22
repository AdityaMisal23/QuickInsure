class Create < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :active, from: nil, to: true
    change_column_default :screens, :active, from: nil, to: true
    change_column_default :theaters, :active, from: nil, to: true
    rename_column :users, :active, :is_active
    rename_column :screens, :active, :is_active
    rename_column :theaters, :active, :is_active
  end
end
