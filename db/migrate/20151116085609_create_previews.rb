class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.string :filename

      t.timestamps null: false
    end
  end
end
