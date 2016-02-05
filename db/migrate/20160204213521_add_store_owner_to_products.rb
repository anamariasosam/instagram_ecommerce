class AddStoreOwnerToProducts < ActiveRecord::Migration
  def change
    add_column :products, :store_owner, :string
  end
end
