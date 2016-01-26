class AddStoreImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :store_image, :string
  end
end
