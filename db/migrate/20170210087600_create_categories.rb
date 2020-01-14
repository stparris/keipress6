class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
    	t.string :name
    	t.string :nice_url, index: true
    	t.references :site, index: true
      t.timestamps null: false
    end
    add_foreign_key :categories, :sites, on_delete: :cascade
  end
end