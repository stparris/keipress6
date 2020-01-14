class BookingTransaction < ApplicationRecord
	belongs_to :booking
	belongs_to :payment_type
	belongs_to :billing_address, class_name: 'UserBillingAddress', foreign_key: :billing_address_id, optional: true 
	belongs_to :card_address, class_name: 'UserCardAddress', foreign_key: :card_address_id, optional: true 
	attr_accessor :name_on_card, :card_number, :card_month, :card_year, :verification_value
	
end
