class CreateRentalBookingInstructions < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_booking_instructions do |t|
    	t.string :name
    	t.string :css_classes
    	t.string :locale
      t.string :regular_rate_instructions
      t.string :discount_rate_instructions
    	t.text :booking_instructions
    	t.text :payment_instructions
    	t.string :booking_button_text
    	t.references :rental
      t.timestamps
    end

    add_foreign_key :rental_booking_instructions, :rentals, on_delete: :cascade 
  end
end
