class CreateCategoriesContents < ActiveRecord::Migration[5.2]

  def change
    create_table :categories_contents, :id => false do |t|
    	t.references :category, index: true
    	t.references :content, index: true
    end
    add_foreign_key :categories_contents, :categories, on_delete: :cascade
    add_foreign_key :categories_contents, :contents, on_delete: :cascade
  end

end

