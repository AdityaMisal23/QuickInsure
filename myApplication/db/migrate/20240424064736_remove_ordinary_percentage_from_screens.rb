class RemoveOrdinaryPercentageFromScreens < ActiveRecord::Migration[7.1]
  def change
    remove_column :screens, :ordinary_percentage
  end
end
