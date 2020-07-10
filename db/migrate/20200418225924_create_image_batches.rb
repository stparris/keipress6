class CreateImageBatches < ActiveRecord::Migration[6.0]
  def change
    create_table :image_batches do |t|
      t.string :name
      t.string :caption
      t.integer :copyright_year
      t.string :copyright_by
      t.string :naming_method
      t.string :naming_prefix
      t.integer :naming_sequence, default: 1
      t.text :description
      t.integer :quality
      t.boolean :publish, default: false, null: false
      t.references :image_group
      t.references :category
      t.references :site, index: true
      t.timestamps null: false
    end
    add_foreign_key :image_batches, :sites, on_delete: :cascade
    add_foreign_key :image_batches, :image_groups, on_delete: :nullify
    add_foreign_key :image_batches, :categories, on_delete: :nullify
  end
end

