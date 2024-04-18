class CreateTheaters < ActiveRecord::Migration[7.1]
  def change
    create_table :theaters do |t|
      t.references :users, null: false, foreign_key: true
      t.string :theater_name
      t.string :theater_address
      t.string :location
      t.string :pincode

      t.timestamps
    end
  end
end
