class CreateWatermarks < ActiveRecord::Migration[6.0]
  def change
    create_table :watermarks do |t|
      t.string :name
      t.references :image
      t.string :watermark_type
      t.string :text
      t.string :font
      t.string :color, default: '255,255,255'
      t.string :opacity
      t.string :rotate
      t.string :margin
      t.string :orientation
      t.string :size
      t.references :site
      t.timestamps
    end
    add_foreign_key :watermarks, :images, on_delete: :nullify
    add_foreign_key :watermarks, :sites, on_delete: :cascade
  end
end

