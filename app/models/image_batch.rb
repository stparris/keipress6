class ImageBatch < ApplicationRecord
  belongs_to :site
  has_many :image_batch_images
  has_many :images, through: :image_batch_images
  belongs_to :image_group, optional: true
  belongs_to :category, optional: true

  attr_accessor :image_group_name
  attr_accessor :category_name
  attr_accessor :image_upload

  validates :name, presence: true
  validates :name, uniqueness: { :scope => :site_id, message: " is already in use." }
  validates :naming_method, presence: true
  validates :naming_prefix, presence: true, if: -> { self.naming_method == 'rename_with_sequence' }

end
