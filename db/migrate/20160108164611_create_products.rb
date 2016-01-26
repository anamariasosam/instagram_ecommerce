class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :price
      t.integer :quantity
      t.string :instagram_image
      t.text :description
      t.string :magic_code

      t.timestamps null: false
    end
  end
end
