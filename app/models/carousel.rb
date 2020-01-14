class Carousel < ApplicationRecord
	belongs_to :site
	has_many :carousel_slides
 	
	validates :name, presence: true
	validates :name, uniqueness: { :scope => :site_id, message: " name is already in use." }

	before_save :prepend_css

	def added_css_classes
		self.css_classes.sub(/^carousel\sslide\s/,'') if self.css_classes
	end

	def prepend_css
		self.css_classes = "carousel slide #{self.added_css_classes}"
	end

end
