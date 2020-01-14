class Artist < Admin
	before_create :set_admin_type

	def set_admin_type
		self.admin_type = 'artist'
	end
	
end
