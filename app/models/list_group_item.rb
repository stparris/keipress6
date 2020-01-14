class ListGroupItem < ApplicationRecord

	belongs_to :list_group
	belongs_to :page, optional: true
	belongs_to :category, optional: true
	belongs_to :link_text, optional: true

	validates :name, presence: true
	validates :name, uniqueness: { scope: :list_group_id, message: " is already in use for this list" }
	validate :check_item_exclusive_arc

	before_save :prepend_css

	def added_css_classes
		self.css_classes.sub(/^list-group-item\s/,'') if self.css_classes
	end

	def prepend_css
		self.css_classes = "list-group-item #{self.added_css_classes}"
	end

	def check_item_exclusive_arc
		if self.item_type == 'plain_text' or self.item_type == 'external_link' and not self.link_text_id
			raise ExclusiveArcError.new("A link text was not found for this item.") 
		elsif self.item_type == 'category_link' and not self.category_id
			raise ExclusiveArcError.new("Category is required.") 
		elsif self.item_type == 'page_link' and not self.page_id
			raise ExclusiveArcError.new("Page is required.") 
		end
	end

  class ExclusiveArcError < StandardError
  	def initialize(message)
  		@message = message
  	end
  	def message
  		@message
  	end
  end

end

