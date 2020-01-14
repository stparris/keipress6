class CreateThemeColors < ActiveRecord::Migration[5.2]
  def change
    create_table :theme_colors do |t|
    	t.string :name
    	t.string :value
      t.references :theme, index: true
      t.references :palette_color, index: true
      t.timestamps
    end
    add_foreign_key :theme_colors, :themes, on_delete: :cascade
    add_foreign_key :theme_colors, :palette_colors, on_delete: :cascade
  end
end
