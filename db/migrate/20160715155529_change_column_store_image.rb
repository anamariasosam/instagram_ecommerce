class ChangeColumnStoreImage < ActiveRecord::Migration
  def change
    rename_column :users, :store_image, :image
  end
end
