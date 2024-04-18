class AddActiveToScreens < ActiveRecord::Migration[7.1]
  def change
    add_column :screens, :active, :boolean
  end
end
