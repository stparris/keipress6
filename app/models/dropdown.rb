class Dropdown < ApplicationRecord

	belongs_to :site
	has_many :dropdown_items
	has_many :navigation_items

	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: " already exists" }

	before_save :prepend_css

	def added_css_classes
		self.css_classes.sub(/^dropdown-menu\s/,'') if self.css_classes
	end

	def prepend_css
		self.css_classes = "dropdown-menu #{self.added_css_classes}"
	end
	
end
