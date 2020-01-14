class ContentContainer < Container

	before_create :set_type
	before_save :prepend_container

	def set_type
		self.container_type = 'grid'
	end

	def added_css_classes
		self.css_classes.gsub(/^container\s/,'') if self.css_classes
	end

	def prepend_container
		self.css_classes = "container #{self.added_css_classes}"
	end

end