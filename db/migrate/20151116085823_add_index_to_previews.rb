class AddIndexToPreviews < ActiveRecord::Migration
  def change
    add_index :previews, :filename
  end
end
