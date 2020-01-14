class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
     	t.string :name
    	t.string :nice_url, index: true
    	t.text :description
    	t.string :assignment, index: true
      t.integer :site_id, index: true
      t.integer :theme_id
      t.timestamps null: false
    end
    add_foreign_key :pages, :sites, on_delete: :cascade
    add_foreign_key :pages, :themes, on_delete: :nullify
  end
end
