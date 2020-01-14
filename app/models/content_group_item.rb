class ContentGroupItem < ContentItem
	
	belongs_to :content_group, foreign_key: :content_id 
	after_create :reset_positions
	after_destroy :reset_positions

  def reset_positions
    self.content_group.content_group_items.each_with_index do |item, index|
      item.update_attribute(:position, index + 1)
    end
  end
 
end
