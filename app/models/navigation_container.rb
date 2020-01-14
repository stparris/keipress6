class NavigationContainer < Container

	before_create :set_type

	def set_type
		self.container_type = 'navigation'
	end

end