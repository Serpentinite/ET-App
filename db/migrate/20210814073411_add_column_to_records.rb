class AddColumnToRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :records, :day, :date, null: false
  end
end
