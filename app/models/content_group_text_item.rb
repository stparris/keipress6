class ContentGroupTextItem < ContentGroupItem	
	belongs_to :content_group, foreign_key: :content_id 
end
