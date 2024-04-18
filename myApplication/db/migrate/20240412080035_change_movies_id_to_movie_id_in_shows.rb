class ChangeMoviesIdToMovieIdInShows < ActiveRecord::Migration[7.1]
  def change
    rename_column :shows, :movies_id, :movie_id
  end
end
