class CreateListGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :list_groups do |t|
    	t.string :name
    	t.references :site, index: true
    	t.string :css_classes
    	t.timestamps null: false
    end
    add_foreign_key :list_groups, :sites, on_delete: :cascade
  end
end
