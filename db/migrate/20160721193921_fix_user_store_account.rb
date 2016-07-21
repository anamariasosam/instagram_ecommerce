class FixUserStoreAccount < ActiveRecord::Migration
  def change
    rename_column :users, :store_account, :instagram_account
  end
end
