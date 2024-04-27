class CreateSeats < ActiveRecord::Migration[7.1]
  def change
    create_table :seats do |t|
      t.integer :resource_id
      t.string :resource_type

      t.timestamps
    end
  end
end
