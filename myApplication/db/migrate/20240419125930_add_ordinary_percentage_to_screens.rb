class AddOrdinaryPercentageToScreens < ActiveRecord::Migration[7.1]
  def change
    add_column :screens, :ordinary_percentage, :Decimal
  end
end
