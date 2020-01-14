class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
    	t.string :name
    	t.string :caption
      t.integer :copyright_year
      t.string :copyright_by
      t.text :description      
      t.references :site, index: true
      t.timestamps null: false
    end
    add_foreign_key :images, :sites, on_delete: :cascade
  end
end

