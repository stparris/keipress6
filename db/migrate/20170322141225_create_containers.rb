class CreateContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :containers do |t|
      t.string :name
			t.references :site, index: true
      t.string :container_type, null: false
      t.references :navigation
      t.references :content
      t.references :medium
      t.references :image
      t.references :carousel
      t.integer :rows_flag, limit: 8
      t.string :css_classes
      t.timestamps null: false
    end

    execute <<-SQL
      ALTER TABLE 
        containers 
      ADD CONSTRAINT check_container_exclusive_arc
        check(((navigation_id is not null)::integer + 
        (content_id is not null)::integer +
        (medium_id is not null)::integer +
        (image_id is not null)::integer +
        (carousel_id is not null)::integer +
        (rows_flag is not null)::integer) = 1)
    SQL
    execute "create unique index on containers (id,navigation_id) where navigation_id is not null"
    execute "create unique index on containers (id,content_id) where content_id is not null"
    execute "create unique index on containers (id,medium_id) where medium_id is not null"
    execute "create unique index on containers (id,image_id) where image_id is not null"
    execute "create unique index on containers (id,carousel_id) where carousel_id is not null"
    execute "create unique index on containers (id,rows_flag) where rows_flag is not null"

    add_foreign_key :containers, :sites, on_delete: :cascade
    add_foreign_key :containers, :navigations, on_delete: :cascade
    add_foreign_key :containers, :contents, on_delete: :cascade
    add_foreign_key :containers, :media, on_delete: :cascade
    add_foreign_key :containers, :images, on_delete: :cascade
    add_foreign_key :containers, :carousels, on_delete: :cascade
  end
end