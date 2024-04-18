class AddGenreAndReleaseDateInMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :genre, :string
    add_column :movies, :release_date, :date
  end
end
