class BlogPost < ContentItem

	belongs_to :admin
	belongs_to :blog, foreign_key: 'content_id'
	belongs_to :video, foreign_key: 'medium_id', optional: true
	belongs_to :image, optional: true
	belongs_to :carousel, optional: true
	belongs_to :image_group, optional: true
	belongs_to :list_group, optional: true
	belongs_to :link_text, optional: true

	before_create :set_position
	after_destroy :reset_positions
	before_create :set_name

  def reset_positions
    self.content.content_items.each_with_index do |item, index|
      item.update_attribute(:position, index + 1)
    end
  end	

	def set_position
		BlogPost.where(content_id: self.content_id).order('position asc').each do |post|
			post.position = post.position + 1
			post.save
		end
		self.position = 1 
	end

	def set_name
		self.name || self.name = self.body =~ /\S+/ ? self.body.strip_tags.truncate : "Post ##POSITION##"
	end

	def default_name
		"Post #{self.postion}"
	end

end