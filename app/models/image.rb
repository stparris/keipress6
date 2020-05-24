class Image < ApplicationRecord

	has_many :containers
	has_many :carousel_slides
	has_many :image_group_items
 	has_many :categories_images
 	has_many :categories, through: :categories_images
	has_one_attached :image
  has_many :image_previews

  after_destroy :clean_up

  def clean_up
    FileUtils.rm Dir.glob("#{Rails.root}/public/image_previews/*_#{self.id}.*")
  end

end
