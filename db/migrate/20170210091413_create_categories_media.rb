class CreateCategoriesMedia < ActiveRecord::Migration[5.2]

  def change
    create_table :categories_media, :id => false do |t|
    	t.references :category, index: true
    	t.references :medium, index: true
    end
    add_foreign_key :categories_media, :categories, on_delete: :cascade
    add_foreign_key :categories_media, :media, on_delete: :cascade
  end

end