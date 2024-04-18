class AddActiveToTheater < ActiveRecord::Migration[7.1]
  def change
    add_column :theaters, :active, :boolean
  end
end
