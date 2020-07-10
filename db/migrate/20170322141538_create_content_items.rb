#
# Using Exclusive Belongs To (AKA Exclusive Arc)
# https://hashrocket.com/blog/posts/modeling-polymorphic-associations-in-a-relational-database#exclusive-belongs-to-aka-exclusive-arc-
#
# Takes advantage of Postgres check constraint and unique indexes
#

class CreateContentItems < ActiveRecord::Migration[5.2]
  def change
    create_table :content_items do |t|
    	t.string :name
      t.string :type, null: false
      t.string :css_classes
      t.references :content, index: true
      t.string :content_type, null: false
      t.references :image
      t.references :carousel
      t.references :image_group
      t.references :medium
      t.references :list_group
      t.references :link_text
      t.integer :text_html_flag, limit: 8
      t.text :body
      t.references :admin
      t.boolean :include_admin_handle, default: false, null: false
      t.boolean :include_update_time, default: false, null: false
      t.boolean :include_caption, default: false, null: false
      t.boolean :include_copyright, default: false, null: false
      t.boolean :include_description, default: false, null: false
      t.integer :position
      t.timestamps null: false
    end
    execute <<-SQL
      ALTER TABLE
        content_items
      ADD CONSTRAINT check_content_item_exclusive_arc
        check(((image_id is not null)::integer +
        (carousel_id is not null)::integer +
        (image_group_id is not null)::integer +
        (medium_id is not null)::integer +
        (list_group_id is not null)::integer +
        (link_text_id is not null)::integer +
        (text_html_flag is not null)::integer) = 1)
    SQL
    execute "create unique index on content_items (id,image_id) where image_id is not null"
    execute "create unique index on content_items (id,carousel_id) where carousel_id is not null"
    execute "create unique index on content_items (id,image_group_id) where image_group_id is not null"
    execute "create unique index on content_items (id,medium_id) where medium_id is not null"
    execute "create unique index on content_items (id,list_group_id) where list_group_id is not null"
    execute "create unique index on content_items (id,link_text_id) where link_text_id is not null"
    execute "create unique index on content_items (id,text_html_flag) where text_html_flag is not null"

    add_foreign_key :content_items, :contents, on_delete: :cascade
    add_foreign_key :content_items, :images, on_delete: :nullify
    add_foreign_key :content_items, :carousels, on_delete: :nullify
    add_foreign_key :content_items, :image_groups, on_delete: :nullify
    add_foreign_key :content_items, :media, on_delete: :nullify
    add_foreign_key :content_items, :list_groups, on_delete: :nullify
    add_foreign_key :content_items, :link_texts, on_delete: :nullify
    add_foreign_key :content_items, :admins, on_delete: :nullify
  end
end

