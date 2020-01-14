class CreateContainersPages < ActiveRecord::Migration[5.2]
  def change
    create_table :containers_pages do |t|
			t.references :container, index: true
  		t.references :page, index: true
  		t.integer :position
    end
    add_foreign_key :containers_pages, :containers, on_delete: :cascade
    add_foreign_key :containers_pages, :pages, on_delete: :cascade
  end
end