class AddColumnHstoreToUsers < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :users, :details, :hstore
  end
end
