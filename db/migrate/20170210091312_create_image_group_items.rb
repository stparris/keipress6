class CreateImageGroupItems < ActiveRecord::Migration[5.2]
  def change
    create_table :image_group_items do |t|
      t.string :name
      t.string :caption
      t.text :body
      t.references :image_group, index: true
      t.references :image, index: true
      t.string :css_classes
      t.integer :position
    end
    add_foreign_key :image_group_items, :images, on_delete: :cascade
    add_foreign_key :image_group_items, :image_groups, on_delete: :cascade
  end
end
