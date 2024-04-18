class ChangeScreensIdToScreenIdInShows < ActiveRecord::Migration[7.1]
  def change
    rename_column :shows, :screens_id, :screen_id
  end
end
