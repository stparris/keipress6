require 'dimensions'

class ImagePreview < ApplicationRecord
  belongs_to :image, optional: true
  belongs_to :parent, :class_name => 'ImagePreview', :foreign_key => :parent_id, optional: true
  has_many :children, :class_name => 'ImagePreview', :foreign_key => :parent_id

  attr_accessor :upload_file, :max_width

  validate :image_validation

  before_validation :set_file_info

  def file_extention
    return case self.content_type
      when /gif/i then 'gif'
      when /png/i then 'png'
      else 'jpg'
    end
  end

  def set_file_info
    if self.source_file
      file = "#{Rails.root}/public/image_previews/#{self.preview_type}_#{self.image_id}.#{self.file_extention}"
      if File.exists?(file)
        self.size = File.new(file).size
        dimensions = Dimensions.dimensions(file)
        self.width = dimensions[0]
        self.height = dimensions[1]
      end
    end
  end


  def get_max_width
    return case
      when self.width >= 1920
        1920
      when self.width >= 1600
        1600
      when self.width >= 1366
        1366
      when self.width >= 1024
        1024
      else
        768
    end
  end

  def image_validation
    if self.content_type == 'original'
      raise ImageTooBigError if self.size > 4000000
      raise ImageInvalidTypeError unless self.content_type =~ /jpeg|jpg|png|gif/
    end
  end

  class ImageTooBigError < StandardError
    def message
      "The image you are uploading is too large. The image must be less than 4 mb."
    end
  end

  class ImageInvalidTypeError < StandardError
    def message
      "The image you are uploading is not a valid type."
    end
  end

end
