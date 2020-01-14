class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
    	t.string :name
    	t.references :site
      t.timestamps null: false
    end
    add_index :domains, :name, unique: true
    add_foreign_key :domains, :sites, on_delete: :cascade
  end
end
