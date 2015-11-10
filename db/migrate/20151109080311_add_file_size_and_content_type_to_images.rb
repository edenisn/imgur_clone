class AddFileSizeAndContentTypeToImages < ActiveRecord::Migration
  def change
    add_column :images, :file_size, :integer
    add_column :images, :content_type, :string
  end
end
