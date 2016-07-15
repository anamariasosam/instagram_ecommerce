class RemoveAddressInUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :address
  end
end
