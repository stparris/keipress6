class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
    	t.string :name
    	t.string :description
    	t.string :keywords
      t.string :favicon
    	t.string :analytics
      t.string :time_zone
      t.references :country
      t.timestamps null: false
    end

    add_index :sites, :name, unique: true
    add_foreign_key :sites, :countries, on_delete: :nullify

  end
end
