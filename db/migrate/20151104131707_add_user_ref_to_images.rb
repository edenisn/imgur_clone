class AddUserRefToImages < ActiveRecord::Migration
  def change
    add_reference :images, :user, index: true, foreign_key: true, null: true
  end
end
