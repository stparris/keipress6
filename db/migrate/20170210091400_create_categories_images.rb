class CreateCategoriesImages < ActiveRecord::Migration[5.2]

  def change
    create_table :categories_images, :id => false do |t|
    	t.references :category, index: true
    	t.references :image, index: true
    end
    add_foreign_key :categories_images, :categories, on_delete: :cascade
    add_foreign_key :categories_images, :images, on_delete: :cascade
  end

end
