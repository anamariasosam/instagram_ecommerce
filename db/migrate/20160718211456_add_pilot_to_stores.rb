class AddPilotToStores < ActiveRecord::Migration
  def change
    remove_column :users, :pilot, :boolean
    remove_column :users, :waiting_position, :integer
    Store.update_all(details: { "pilot" => true })
  end
end
