class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :store_name
      t.string :phone_number
      t.string :address
      t.string :email
      t.text :delivery_info

      t.timestamps null: false
    end
  end
end
