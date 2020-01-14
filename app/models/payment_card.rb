class PaymentCard
	include ActiveModel::Model
	include ActiveModel::Validations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_number, presence: true
  validates :card_month, presence: true
  validates :card_year, presence: true
  validates :card_verification, presence: true

  attr_accessor :first_name, :last_name, :brand, :card_number, :expiration_month, :expiration_year, :card_verification, :ip_address

	def config_card
	  ActiveMerchant::Billing::CreditCard.new(
	    :first_name         => self.first_name,
	    :last_name          => self.last_name,
	    :number             => self.card_number,
	    :brand							=> self.brand,
	    :month              => self.expiration_month,
	    :year               => self.expiration_year,
	    :verification_value => self.card_verification
	  )
	end

	def display_number
		self.card_number.sub(/^\d{12}/,'#### #### #### ')
	end 



end
