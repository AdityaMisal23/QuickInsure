class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :bookings, null: false, foreign_key: true
      t.decimal :payment
      t.boolean :status
      t.string :payment_type

      t.timestamps
    end
  end
end
