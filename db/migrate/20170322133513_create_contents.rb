class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :name
      t.string :content_url
      t.string :css_classes
      t.string :type
      t.boolean :published, default: false, null: false
      t.references :page
      t.references :site, index: true
      t.references :admin, index: true
      t.timestamps null: false
    end
    add_foreign_key :contents, :sites, on_delete: :cascade
    add_foreign_key :contents, :pages, on_delete: :nullify
    add_foreign_key :contents, :admins, on_delete: :nullify
  end
end
