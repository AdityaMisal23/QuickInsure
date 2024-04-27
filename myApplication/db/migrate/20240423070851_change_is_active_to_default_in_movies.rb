class ChangeIsActiveToDefaultInMovies < ActiveRecord::Migration[7.1]
  def change
    change_column_default :movies, :is_active, true
  end
end
