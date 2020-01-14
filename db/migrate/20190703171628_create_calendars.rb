class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
    	t.string :name
    	t.references :site
      t.string :calendar_type
    	t.string :import_url
      t.string :export_url
    	t.text :icalendar
      t.boolean :parent, default: false, null: false
      t.timestamps
    end
    add_foreign_key :calendars, :sites, on_delete: :cascade
  end
end
