class CreateBookingTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_transactions do |t|
    	t.references :booking
    	t.references :payment_type
    	t.integer :billing_address_id
      t.integer :card_address_id
    	t.integer :amount
    	t.text :details
      t.timestamps
    end

    add_foreign_key :booking_transactions, :bookings, on_delete: :cascade
    add_foreign_key :booking_transactions, :payment_types, on_delete: :nullify
    add_foreign_key :booking_transactions, :user_addresses, column: :billing_address_id, on_delete: :nullify
    add_foreign_key :booking_transactions, :user_addresses, column: :card_address_id, on_delete: :nullify
  end
end
