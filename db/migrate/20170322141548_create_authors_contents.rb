class CreateAuthorsContents < ActiveRecord::Migration[5.2]

  def change
    create_table :authors_contents, :id => false do |t|
    	t.references :admin, index: true
    	t.references :content, index: true
    end
    add_foreign_key :authors_contents, :admins, on_delete: :cascade
    add_foreign_key :authors_contents, :contents, on_delete: :cascade
  end

end

