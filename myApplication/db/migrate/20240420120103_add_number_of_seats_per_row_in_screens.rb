class AddNumberOfSeatsPerRowInScreens < ActiveRecord::Migration[7.1]
  def change
    add_column :screens,:number_of_seats_per_column , :integer
  end
end
