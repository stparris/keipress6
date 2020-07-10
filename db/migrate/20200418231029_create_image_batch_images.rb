class CreateImageBatchImages < ActiveRecord::Migration[6.0]
  def change
    create_table :image_batch_images do |t|
      t.references :image_batch
      t.references :image
      t.boolean :published, default: false, null: false
    end
    add_foreign_key :image_batch_images, :image_batches, on_delete: :cascade
    add_foreign_key :image_batch_images, :images, on_delete: :cascade
  end
end
