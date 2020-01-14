class CreateDropdownItems < ActiveRecord::Migration[5.2]
  def change
    create_table :dropdown_items do |t|
      t.string :name
      t.string :label
      t.references :dropdown, index: true
     	t.string :css_classes
    	t.string :item_type, null: false
    	t.references :page
      t.references :category
    	t.references :link_text
      t.integer :position
      t.timestamps null: false
    end
    execute <<-SQL
      ALTER TABLE 
        dropdown_items 
      ADD CONSTRAINT check_dropdown_item_exclusive_arc
        check(((link_text_id is not null)::integer + 
          (page_id is not null)::integer + 
          (category_id is not null)::integer) = 1)
      SQL
    execute "create unique index on dropdown_items (id,link_text_id) where link_text_id is not null"
    execute "create unique index on dropdown_items (id,page_id) where page_id is not null"
    execute "create unique index on dropdown_items (id,category_id) where category_id is not null"

    add_foreign_key :dropdown_items, :dropdowns, on_delete: :cascade
    add_foreign_key :dropdown_items, :pages, on_delete: :cascade
    add_foreign_key :dropdown_items, :categories, on_delete: :cascade
    add_foreign_key :dropdown_items, :link_texts, on_delete: :cascade
  end
end