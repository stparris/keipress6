class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
    	t.string :name
      t.string :booking_number
    	t.references :site
    	t.references :user
      t.references :event
      t.references :tour
    	t.references :rental
      t.references :payment_method
      t.string :uuid
    	t.date :start_date
    	t.date :end_date
    	t.text :details
      t.string :status
      t.boolean :email_confirmed, default: false, null: false
    	t.integer :guests
      t.integer :booking_amount
      t.integer :booking_tax
      t.integer :booking_total
      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE 
        bookings 
      ADD CONSTRAINT check_booking_exclusive_arc
        check(((rental_id is not null)::integer + 
          (tour_id is not null)::integer + 
          (event_id is not null)::integer) = 1)
      SQL
    execute "create unique index on bookings (id,rental_id) where rental_id is not null"
    execute "create unique index on bookings (id,tour_id) where tour_id is not null"
    execute "create unique index on bookings (id,event_id) where event_id is not null"

    add_foreign_key :bookings, :sites, on_delete: :cascade
    add_foreign_key :bookings, :users, on_delete: :cascade
    add_foreign_key :bookings, :rentals, on_delete: :cascade
    add_foreign_key :bookings, :tours, on_delete: :cascade
    add_foreign_key :bookings, :events, on_delete: :cascade
    add_foreign_key :bookings, :payment_methods, on_delete: :nullify
  end
end

