class CarouselSlide < ApplicationRecord
	belongs_to :carousel
	belongs_to :image, optional: true
	before_save :prepend_css

	def added_css_classes
		self.css_classes.sub(/^carousel-item\s/,'') if self.css_classes
	end

	def prepend_css
		self.css_classes = "carousel-item #{self.added_css_classes}"
	end


end
