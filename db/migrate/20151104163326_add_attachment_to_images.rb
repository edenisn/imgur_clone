class AddAttachmentToImages < ActiveRecord::Migration
  def change
    add_column :images, :attachment, :string
  end
end
