class RemoveNumberOfSeatsPerColumnFromScreens < ActiveRecord::Migration[7.1]
  def change
    remove_column :screens , :number_of_seats_per_column
  end
end
