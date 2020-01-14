class CreateLinkTexts < ActiveRecord::Migration[5.2]
  def change
    create_table :link_texts do |t|
    	t.references :site, index: true
      t.string :link
      t.text :body
      t.string :test_text
      t.boolean :new_window, default: false, null: false
      t.string :css_classes
      t.timestamps null: false
    end
    add_foreign_key :link_texts, :sites, on_delete: :cascade
  end
end
