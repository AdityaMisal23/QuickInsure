class ChangeDateColumnToDateTime < ActiveRecord::Migration[6.0]
  def change
    # change_column :shows, :show_time, "timestamp USING CAST(CONCAT(show_time, ' 00:00:00') AS timestamp)"
    add_column :shows, :timings, :datetime
  end
end
