class AddIndexUsernameToUsers < ActiveRecord::Migration
  def change
    add_index :users, :username
    change_column :users, :username, :string, null: false
  end
end
