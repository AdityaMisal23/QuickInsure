class AddNumberOfSeatsToScreens < ActiveRecord::Migration[7.1]
  def change
    add_column :screens, :number_of_seats, :integer
  end
end
