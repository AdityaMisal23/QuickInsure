class RemoveTicketPriceFromShows < ActiveRecord::Migration[7.1]
  def change
    remove_column :shows , :ticket_price_ordinary
    remove_column :shows , :ticket_price_premium
  end
end
