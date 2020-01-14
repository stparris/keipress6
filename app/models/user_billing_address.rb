class UserBillingAddress < UserAddress
	attr_accessor :use_primary_address

	before_create :set_name

	def set_name
		self.name = 'billing'
	end

end
