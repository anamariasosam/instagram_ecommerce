class RemoveMagicCodeFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :magic_code, :string
  end
end
