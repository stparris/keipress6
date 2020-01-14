class CreateListGroupItems < ActiveRecord::Migration[5.2]
  def change
    create_table :list_group_items do |t|
      t.string :name
      t.string :label
      t.string :css_classes
      t.string :item_type, null: false
      t.references :list_group, index: true
      t.references :link_text
    	t.references :page
      t.references :category
      t.integer :position
      t.timestamps null: false
    end
    execute "
      ALTER TABLE 
        list_group_items 
      ADD CONSTRAINT check_list_group_item_exclusive_arc
        check(((link_text_id is not null)::integer + (page_id is not null)::integer + (category_id is not null)::integer) = 1)"
    execute "create unique index on list_group_items (id,link_text_id) where link_text_id is not null"
    execute "create unique index on list_group_items (id,page_id) where page_id is not null"
    execute "create unique index on list_group_items (id,category_id) where category_id is not null"

    add_foreign_key :list_group_items, :list_groups, on_delete: :cascade
    add_foreign_key :list_group_items, :link_texts, on_delete: :cascade
    add_foreign_key :list_group_items, :pages, on_delete: :cascade
    add_foreign_key :list_group_items, :categories, on_delete: :cascade
  end
end
