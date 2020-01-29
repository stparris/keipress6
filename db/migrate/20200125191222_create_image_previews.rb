class CreateImagePreviews < ActiveRecord::Migration[6.0]
  def change
    create_table :image_previews do |t|
      t.references :image
      t.integer :parent_id, default: 0
      t.string :preview_type
      t.string :file_name
      t.string :file_type
      t.integer :file_size
      t.string :crop_info
      t.string :optimization_info
      t.boolean :published, default: false, null: false
      t.timestamps
    end

    add_foreign_key :image_previews, :images, on_delete: :cascade
  end
end
