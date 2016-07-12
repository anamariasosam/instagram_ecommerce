class AddColumnTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, :limit => 15
  end
end
