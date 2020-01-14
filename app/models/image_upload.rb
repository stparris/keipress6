class ImageUpload < Image

  validate :image_validation

  def image_validation
    if self.image.attached?
      @image_bytes = self.image.blob.byte_size
      raise ImageTooBigError if self.image.blob.byte_size > 2000000
      raise ImageInvalidTypeError unless self.image.blob.content_type.starts_with?('image/')
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
