class CreatePaletteColors < ActiveRecord::Migration[5.2]
  def change
    create_table :palette_colors do |t|
    	t.string :name
    	t.string :value
    	t.references :palette, index: true
      t.timestamps null: false
    end
    add_foreign_key :palette_colors, :palettes, on_delete: :cascade
  end
end
