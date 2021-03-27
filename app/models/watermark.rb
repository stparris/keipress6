class Watermark < ApplicationRecord

  belongs_to :site
  belongs_to :image, optional: true
  has_one_attached :image

  validates :name, presence: true
  validates :name, uniqueness: { :scope => :site_id }
  validates :watermark_type, presence: true

end
