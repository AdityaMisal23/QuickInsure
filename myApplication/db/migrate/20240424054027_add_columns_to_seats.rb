class AddColumnsToSeats < ActiveRecord::Migration[7.1]
  def change
    add_column :seats , :row , :string
    add_column :seats , :column, :integer
    add_column :seats , :section, :string
  end
end
