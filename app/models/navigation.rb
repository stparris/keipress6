class Navigation < ApplicationRecord

	belongs_to :site
	has_many :navigation_items

	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: " already exists" }

	before_save :main_prepend_css
	before_save :list_prepend_css

	def added_main_css_classes
		self.main_css_classes.sub(/^navbar\s|^nav\s/,'') if self.main_css_classes
	end

	def main_prepend_css
		if self.nav_type == 'navbar'
			self.main_css_classes = "navbar #{self.added_main_css_classes}"
		else
			self.main_css_classes = "nav #{self.added_main_css_classes}"
		end
	end

	def added_list_css_classes
		self.list_css_classes.sub(/^collapse\snavbar-collapse\s/,'') if self.list_css_classes
	end

	def list_prepend_css
		self.list_css_classes = "collapse navbar-collapse #{self.added_list_css_classes}"
	end

end
