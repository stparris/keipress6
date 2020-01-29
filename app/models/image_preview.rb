class ImagePreview < ApplicationRecord
  belongs_to :image, optional: true
  belongs_to :parent, :class_name => 'ImagePreview', :foreign_key => :parent_id, optional: true
  has_many :children, :class_name => 'ImagePreview', :foreign_key => :parent_id

  attr_accessor :upload_file

  validate :image_validation

  def image_validation
    if self.file_type == 'original'
      raise ImageTooBigError if self.file_size > 2000000
      raise ImageInvalidTypeError unless self.file_type =~ /jpg|png|gif/
    end
  end

  class ImageTooBigError < StandardError
    def message
      "The image you are uploading is too large. The image must be less than 2 mb."
    end
  end

  class ImageInvalidTypeError < StandardError
    def message
      "The image you are uploading is not a valid type."
    end
  end

end
