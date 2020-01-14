class CreateAdminsSites < ActiveRecord::Migration[5.2]

  def change
    create_table :admins_sites, :id => false do |t|
    	t.references :admin, index: true
    	t.references :site, index: true
    end
    add_foreign_key :admins_sites, :admins, on_delete: :cascade
    add_foreign_key :admins_sites, :sites, on_delete: :cascade
  end

end

