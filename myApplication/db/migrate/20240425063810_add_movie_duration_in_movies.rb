class AddMovieDurationInMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies , :movie_duration , :decimal
  end
end
