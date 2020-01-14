class CreateCarouselSlides < ActiveRecord::Migration[5.2]
  def change
    create_table :carousel_slides do |t|
      t.string :name
      t.string :caption
			t.text :body
      t.references :image
			t.references :carousel
     	t.string :css_classes
      t.integer :position
      t.timestamps null: false
   	end
    add_foreign_key :carousel_slides, :carousels, on_delete: :cascade
    add_foreign_key :carousel_slides, :images, on_delete: :nullify
  end
end