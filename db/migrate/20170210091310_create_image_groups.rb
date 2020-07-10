class CreateImageGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :image_groups do |t|
    	t.string :name
      t.text :description
      t.string :css_classes
      t.string :image_group_type
      t.boolean :include_caption, default: false
      t.boolean :include_copyright, default: false
      t.boolean :include_body, default: false
      t.references :site, index: true
      t.references :image
      t.timestamps null: false
    end
    add_foreign_key :image_groups, :sites, on_delete: :cascade
    add_foreign_key :image_groups, :images, on_delete: :nullify
  end
end
