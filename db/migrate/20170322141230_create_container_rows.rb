class CreateContainerRows < ActiveRecord::Migration[5.2]
  def change
    create_table :container_rows do |t|
			t.references :container, index: true
      t.string :css_classes
			t.integer :position
    end
    add_foreign_key :container_rows, :containers, on_delete: :cascade
  end
end
