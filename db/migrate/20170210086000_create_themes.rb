class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :name
      t.string :css_class
    	t.text :scss_production
    	t.text :scss_workspace
      t.references :site, index: true
      t.references :admin
      t.timestamps null: false
    end
    add_foreign_key :themes, :sites, on_delete: :cascade
    add_foreign_key :themes, :admins, on_delete: :nullify
  end
end
