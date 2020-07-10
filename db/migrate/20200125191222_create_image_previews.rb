class CreateImagePreviews < ActiveRecord::Migration[6.0]
  def change
    create_table :image_previews do |t|
      t.references :image
      t.integer :parent_id, default: 0
      t.string :preview_type
      t.string :source_file
      t.string :content_type
      t.integer :size, default: 0
      t.integer :width, default: 0
      t.integer :height, default: 0
      t.integer :quality, default: 100
      t.timestamps
    end
    add_foreign_key :image_previews, :images, on_delete: :cascade
  end
end
