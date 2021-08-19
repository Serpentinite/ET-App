class AddDatailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :height, :float
  end
end
