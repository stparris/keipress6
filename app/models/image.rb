class Image < ApplicationRecord

	has_many :containers
	has_many :carousel_slides
	has_many :image_group_items
 	has_many :categories_image
 	has_many :categories, through: :categories_image
	has_one_attached :image
  has_many :image_previews

end
