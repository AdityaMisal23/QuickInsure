class RenameTimingsInShows < ActiveRecord::Migration[7.1]
  def change
    rename_column :shows, :timings, :show_time
  end
end
