class CreateSiteIncludes < ActiveRecord::Migration[5.2]

  def change
    create_table :site_includes do |t|
    	t.string :name
    	t.references :site
    	t.references :page, index: true
    end
    add_foreign_key :site_includes, :sites, on_delete: :nullify
    add_foreign_key :site_includes, :pages, on_delete: :nullify
  end

end

