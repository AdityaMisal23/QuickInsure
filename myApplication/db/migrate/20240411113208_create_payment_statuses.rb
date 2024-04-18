class CreatePaymentStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_statuses do |t|
      t.references :booking_details, null: false, foreign_key: true
      t.decimal :payment
      t.boolean :status

      t.timestamps
    end
  end
end
