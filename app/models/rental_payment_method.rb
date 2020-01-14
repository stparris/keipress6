class RentalPaymentMethod < ApplicationRecord
	belongs_to :rental
	belongs_to :payment_method

	after_create :reset_positions
	after_destroy :reset_positions

  def reset_positions
    self.rental.rental_payment_methods.each_with_index do |item, index|
      item.update_attribute(:position, index + 1)
    end
  end

end
