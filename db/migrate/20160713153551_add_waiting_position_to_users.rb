class AddWaitingPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :waiting_position, :integer
  end
end
