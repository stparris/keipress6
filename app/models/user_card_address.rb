class UserCardAddress < UserAddress
	attr_accessor :use_primary_address

	before_create :set_name

	def set_name
		self.name = 'card'
	end
end
