class CreateShows < ActiveRecord::Migration[7.1]
  def change
    create_table :shows do |t|
      t.references :screens, null: false, foreign_key: true
      t.references :movies, null: false, foreign_key: true
      t.date :show_date
      t.time :show_time
      t.decimal :ticket_price_ordinary
      t.decimal :ticket_price_premium
      t.integer :booked_tickets

      t.timestamps
    end
  end
end
