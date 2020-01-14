class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.string :name
      t.references :site
      t.references :calendar
      t.integer :min_days
      t.integer :max_days
      t.integer :min_guests
      t.integer :max_guests
      t.string :currency
      t.integer :regular_rate
      t.integer :discount_rate
      t.integer :extras_rate
      t.integer :extras_discount_rate
      t.integer :other_fees, default: 0
      t.string :regular_dates
      t.string :discount_dates
      t.decimal :tax_rate, precision: 5, scale: 4, default: 0.000, null: false
      t.decimal :deposit_percent, precision: 5, scale: 4, default: 0.000, null: false
      t.integer :deposit_days, default: 0
      t.integer :cancellation_days, default: 0
      t.text :description
      t.boolean :active, default: true, null: false
      t.timestamps
    end
    add_foreign_key :rentals, :sites, on_delete: :cascade
    add_foreign_key :rentals, :calendars, on_delete: :nullify
  end
end