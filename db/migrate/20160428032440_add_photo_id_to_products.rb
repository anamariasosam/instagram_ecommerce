class AddPhotoIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :photo_id, :string
  end
end
