class ContentItem < ApplicationRecord

	belongs_to :content
	belongs_to :video, foreign_key: 'medium_id', optional: true
	belongs_to :image, optional: true
	belongs_to :carousel, optional: true
	belongs_to :image_group, optional: true
	belongs_to :list_group, optional: true
	belongs_to :link_text, optional: true

	validates :name, presence: true
	validate :check_content_item_exclusive_arc

	before_save :set_text_html

	attr_accessor :text_html

	def set_text_html
		if !self.text_html_flag && self.text_html
			last_flag = ContentItem.maximum('text_html_flag') || 1
			self.text_html_flag = self.text_html ? last_flag + 1 : nil 
		end
	end

  def check_content_item_exclusive_arc
  	if self.content_type == 'image' and not self.image_id	
  		raise ExclusiveArcError.new("Image is required, please select")
  	elsif self.content_type == 'image_group' and not self.image_group_id	
  		raise ExclusiveArcError("Image group is required, please select")
  	elsif self.content_type == 'list_group' and not self.list_group_id	
  		raise ExclusiveArcError("List group is required, please select")
  	elsif self.content_type == 'carousel' and not self.carousel_id	
  		raise ExclusiveArcError("Carousel is required, please select")
  	elsif self.content_type == 'video' and not self.medium_id	
  		raise ExclusiveArcError("Video is required, please select")  	  		
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
