class RowColumn < ApplicationRecord
	belongs_to :content, optional: true
	belongs_to :image_group, optional: true
	belongs_to :category, optional: true
	belongs_to :carousel, optional: true
	belongs_to :list_group, optional: true
	belongs_to :container_row

	attr_accessor :grid_columns, :grid_break_point, :grid_image_height

	before_save :ensure_col
	before_create :set_position
	before_save :set_column_type

	validate :check_content_item_exclusive_arc

	def set_column_type
		if self.grid_columns && self.grid_break_point
			self.content_type = "image_grid_fixed_#{self.grid_break_point}_#{self.grid_columns}_columns"
		end
		if self.grid_image_height
			height = self.grid_image_height.to_i > 99 && self.grid_image_height.to_i < 501 ? self.grid_image_height : "250" 
			self.content_type = "image_grid_masonry_#{height}_px"
		end
	end

	def ensure_col
		self.css_classes = "col" unless self.css_classes =~ /\S+/
	end

	def set_position
		self.position = RowColumn.where(container_row_id: self.container_row_id).count + 1
	end

  def check_content_item_exclusive_arc
  	if self.content_type == 'content_group' and not self.content_id	
  		raise ExclusiveArcError.new("Content group is required, please select")
  	elsif self.content_type =~ /image/ and not self.image_group_id	
  		raise ExclusiveArcError("Image group is required, please select")
  	elsif self.content_type == 'list_group' and not self.list_group_id	
  		raise ExclusiveArcError("List group is required, please select")
  	elsif self.content_type == 'carousel' and not self.carousel_id	
  		raise ExclusiveArcError("Carousel is required, please select")
  	elsif self.content_type == 'category' and not self.category_id	
  		raise ExclusiveArcError("Category is required, please select")  	  		
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
