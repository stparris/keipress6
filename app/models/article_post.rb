class ArticlePost < ContentItem

	belongs_to :article, foreign_key: 'content_id'
	belongs_to :video, foreign_key: 'medium_id', optional: true
	belongs_to :image, optional: true
	belongs_to :carousel, optional: true
	belongs_to :image_group, optional: true
	belongs_to :list_group, optional: true
	belongs_to :link_text, optional: true

	before_create :set_position

	def set_position
		self.position = ArticlePost.where(content_id: self.content_id).count + 1 unless self.position
	end

end
