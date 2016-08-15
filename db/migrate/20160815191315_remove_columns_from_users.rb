class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :store_name
    remove_column :users, :delivery_info
  end
end
