class AddUserTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_token, :string
  end
end
