class AddGoldSilverPlatinumToShows < ActiveRecord::Migration[7.1]
  def change
    add_column :shows, :gold , :decimal
    add_column :shows, :silver , :decimal
    add_column :shows, :platinum , :decimal
  end
end
