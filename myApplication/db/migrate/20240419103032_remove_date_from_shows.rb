class RemoveDateFromShows < ActiveRecord::Migration[7.1]
  def change
    remove_column :shows, :show_date
  end
end
