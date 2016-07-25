class AddStoreAndCustomerToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :customer_id, :integer
    add_foreign_key :orders, :users, column: :customer_id, primary_key: :id
    add_column :orders, :store_id, :integer
    add_foreign_key :orders, :users, column: :store_id, primary_key: :id
  end
end
