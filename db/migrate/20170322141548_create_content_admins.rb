class CreateContentAdmins < ActiveRecord::Migration[5.2]

  def change
    create_table :content_admins do |t|
    	t.references :admin, index: true
    	t.references :content, index: true
      t.integer :position
    end
    add_foreign_key :content_admins, :admins, on_delete: :cascade
    add_foreign_key :content_admins, :contents, on_delete: :cascade
  end

end

