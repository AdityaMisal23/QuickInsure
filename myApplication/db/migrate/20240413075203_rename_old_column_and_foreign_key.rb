class RenameOldColumnAndForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_column :theaters, :location
  end
end
