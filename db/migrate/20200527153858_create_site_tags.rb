class CreateSiteTags < ActiveRecord::Migration[6.0]
  def change
    create_table :site_tags do |t|
      t.references :site
      t.string :name
      t.string :tag_type
      t.text :value
      t.integer :position
      t.timestamps
    end
    add_foreign_key :site_tags, :sites, on_delete: :cascade
  end
end
