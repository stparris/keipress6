class ImageGroupItem < ApplicationRecord
	belongs_to :image_group
	belongs_to :image

  attr_accessor :category_id

  after_create :reset_positions
	after_destroy :reset_positions

  def reset_positions
    self.image_group.image_group_items.each_with_index do |item, index|
      item.update_attribute(:position, index + 1)
    end
  end


end
