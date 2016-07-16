class AddStoresToProduct < ActiveRecord::Migration
  def change
    add_column :products, :store_id, :integer
    add_foreign_key :products, :users, column: :store_id, primary_key: :id
    Product.update_all("store_id = user_id")
    remove_column :products, :user_id, :integer
  end
end
