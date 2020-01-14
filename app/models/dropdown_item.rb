class DropdownItem < ApplicationRecord

	belongs_to :dropdown
	belongs_to :page, optional: true
	belongs_to :category, optional: true
	belongs_to :link_text, optional: true

	validates :name, presence: true
	validate :check_dropdown_item_exclusive_arc

	attr_accessor :dropdown_item_css

	def added_css_classes
		self.css_classes.sub(/^nav-item\s/,'') if self.css_classes
	end

	def prepend_css
		self.css_classes = "nav-item #{self.added_css_classes}"
	end

  def check_dropdown_item_exclusive_arc
  	if self.item_type == 'page_link' and not self.page_id	
  		raise ExclusiveArcError.new("Page is required, please select")
  	elsif self.item_type == 'category_link' and not self.category_id	
  		raise ExclusiveArcError.new("Category is required, please select")
  	elsif self.item_type == 'external_link' and not self.link_text_id	
  		raise ExclusiveArcError.new("External link is missing")
  	else
  		true
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
