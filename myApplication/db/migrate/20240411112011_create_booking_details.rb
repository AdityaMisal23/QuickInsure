class CreateBookingDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_details do |t|
      t.references :users, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true
      t.string :seats

      t.timestamps
    end
  end
end
