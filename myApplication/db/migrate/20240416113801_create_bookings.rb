class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true
      t.string :seats

      t.timestamps
    end
  end
end
