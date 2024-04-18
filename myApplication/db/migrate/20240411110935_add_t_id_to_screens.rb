class AddTIdToScreens < ActiveRecord::Migration[7.1]
  def change
    add_reference :screens, :theaters, null: false, foreign_key: true
  end
end
