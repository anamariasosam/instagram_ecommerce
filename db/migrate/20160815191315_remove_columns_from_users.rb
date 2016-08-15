class RemoveColumnsFromUsers < ActiveRecord::Migration
  # Remove the column store_name and delivery_info
  def change
    remove_column :users, :store_name
    remove_column :users, :delivery_info
  end
end
