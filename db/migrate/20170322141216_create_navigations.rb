class CreateNavigations < ActiveRecord::Migration[5.2]
  def change
    create_table :navigations do |t|
    	t.string :name
    	t.references :site, index: true
    	t.string :main_css_classes
      t.string :list_css_classes
      t.string :nav_type, null: false
    	t.text :brand
    	t.text :form
      t.timestamps null: false
    end
    add_foreign_key :navigations, :sites, on_delete: :cascade
  end
end