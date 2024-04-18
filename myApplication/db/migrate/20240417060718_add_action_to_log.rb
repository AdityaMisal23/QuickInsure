class AddActionToLog < ActiveRecord::Migration[7.1]
  def change
    add_column :logs , :action ,  :string 
  end
end
