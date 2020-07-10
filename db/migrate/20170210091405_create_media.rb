class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
    	t.string :name
      t.string :type, null: false
    	t.string :caption
      t.integer :copyright_year
      t.string :copyright_by
      t.text :description
      t.references :image
      t.references :site, index: true
      t.timestamps null: false
    end
    add_foreign_key :media, :sites, on_delete: :cascade
    add_foreign_key :media, :images, on_delete: :nullify
  end
end
