class PaymentType < ApplicationRecord
	belongs_to :site
	belongs_to :payment_gateway, optional: true
	
	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: " is already in use for this site" }

	def self.types
		{
			"Card Full Payment"=>"card_paid",
			"Card Deposit Payment"=>"card_deposit",
			"Check"=>"check",
			"Invoice"=>"invoice",
			"Contact form"=>"contact_form",
			"Special Instructions"=>"special_instructions"
		}
	end

	def addresses 
		addresses = []
		addresses << 'primary' if self.show_primary_address || self.billing_required || self.shipping_required
		addresses << 'billing' if self.billing_required
		addresses << 'shipping' if self.shipping_required
	end

end
