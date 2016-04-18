class AddStoreAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :store_account, :string
  end
end
