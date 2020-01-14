class CreateRentalPaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_payment_methods do |t|
    	t.references :payment_method
    	t.references :rental
    	t.integer :position
    end

    add_foreign_key :rental_payment_methods, :payment_methods, on_delete: :cascade
    add_foreign_key :rental_payment_methods, :rentals, on_delete: :cascade
  end
end
