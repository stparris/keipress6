class CreateDropdowns < ActiveRecord::Migration[5.2]
  def change
    create_table :dropdowns do |t|
    	t.string :name
    	t.references :site, index: true
    	t.string :css_classes
      t.string :nav_type, null: false
      t.timestamps null: false
    end
    add_foreign_key :dropdowns, :sites, on_delete: :cascade
  end
end