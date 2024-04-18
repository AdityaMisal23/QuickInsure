class AddNewColumToTheaters < ActiveRecord::Migration[7.1]
  def change
    add_reference :theaters, :locations, foreign_key: true
  end
end
