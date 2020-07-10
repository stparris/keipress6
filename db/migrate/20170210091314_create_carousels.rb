class CreateCarousels < ActiveRecord::Migration[5.2]
  def change
    create_table :carousels do |t|
    	t.string :name
      t.text :description
      t.string :css_classes
      t.string :carousel_type, default: 'carousel'
      t.boolean :with_controls, default: false, null: false
      t.boolean :with_indicators, default: false, null: false
      t.boolean :with_captions, default: false, null: false
      t.boolean :with_copyrights, default: false, null: false
      t.boolean :with_pause, default: false, null: false
      t.boolean :with_ride, default: false, null: false
      t.integer :interval, default: 0
      t.references :site, index: true
      t.timestamps null: false
    end
    add_foreign_key :carousels, :sites, on_delete: :cascade
  end
end

