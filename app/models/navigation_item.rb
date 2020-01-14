class NavigationItem < ApplicationRecord

	belongs_to :navigation
	belongs_to :page, optional: true
	belongs_to :category, optional: true
	belongs_to :list_group, optional: true
	belongs_to :link_text, optional: true
	belongs_to :dropdown, optional: true

	validates :name, presence: true
	validates :name, uniqueness: { scope: :navigation_id, message: " is in use for this navigation" }
	validates :label, presence: true
	
	attr_accessor :dropdown_css

	before_save :prepend_css

	def added_css_classes
		self.css_classes.sub(/^nav-item\s|dropdown\s/,'') if self.css_classes
	end

	def prepend_css
		nav_css = self.dropdown_css ? "nav-item dropdown" : "nav-item"
		self.css_classes = "#{nav_css} #{self.added_css_classes}"
	end


end

