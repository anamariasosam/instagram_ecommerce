class AddColumnPilotToUser < ActiveRecord::Migration
  def change
    add_column :users, :pilot, :boolean
  end
end
