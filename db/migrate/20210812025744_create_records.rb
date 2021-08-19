class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.float :weight, null: false

      t.timestamps
    end
  end
end
