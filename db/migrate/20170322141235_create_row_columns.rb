class CreateRowColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :row_columns do |t|
			t.references :container_row
      t.string :css_classes
      t.string :content_type
			t.references :content
      t.references :category
      t.references :image_group
      t.references :carousel
      t.references :list_group
      t.integer :placeholder_flag, limit: 8
			t.integer :position
    end
    execute <<-SQL
      ALTER TABLE
        row_columns
      ADD CONSTRAINT check_row_column_exclusive_arc
        check(((content_id is not null)::integer +
        (category_id is not null)::integer +
        (image_group_id is not null)::integer +
        (carousel_id is not null)::integer +
        (list_group_id is not null)::integer +
        (placeholder_flag is not null)::integer) = 1)
      SQL
    execute "create unique index on row_columns (id,content_id) where content_id is not null"
    execute "create unique index on row_columns (id,category_id) where category_id is not null"
    execute "create unique index on row_columns (id,image_group_id) where image_group_id is not null"
    execute "create unique index on row_columns (id,carousel_id) where carousel_id is not null"
    execute "create unique index on row_columns (id,list_group_id) where list_group_id is not null"
    execute "create unique index on row_columns (id,placeholder_flag) where placeholder_flag is not null"

    add_foreign_key :row_columns, :container_rows, on_delete: :cascade
    add_foreign_key :row_columns, :contents, on_delete: :nullify
    add_foreign_key :row_columns, :categories, on_delete: :nullify
    add_foreign_key :row_columns, :image_groups, on_delete: :nullify
    add_foreign_key :row_columns, :carousels, on_delete: :nullify
    add_foreign_key :row_columns, :list_groups, on_delete: :nullify
  end
end
