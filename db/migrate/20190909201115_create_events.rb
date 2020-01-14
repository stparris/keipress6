class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.references :site
      t.references :calendar
      t.date :start_date
      t.date :end_date
      t.string :currency
      t.integer :regular_rate
      t.integer :other_fees, default: 0
      t.decimal :tax_rate, precision: 5, scale: 4, default: 0.000
      t.text :description
      t.boolean :active, default: true, null: false
      t.timestamps
    end
    add_foreign_key :events, :sites, on_delete: :cascade
    add_foreign_key :events, :calendars, on_delete: :nullify
  end
end

