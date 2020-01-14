class CreateMailServers < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_servers do |t|
    	t.string :name
    	t.references :site
      t.json :config
      t.boolean :active, default: true, null: false
      t.timestamps
    end
    add_foreign_key :mail_servers, :sites, on_delete: :cascade
  end
end
