class AddColumnToBoards < ActiveRecord::Migration[5.0]
  def change
    add_reference :boards, :user, foreign_key: true
  end
end
