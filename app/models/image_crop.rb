class ImageCrop < ImagePreview
  belongs_to :image_preview, class_name: 'ImagePreview', foreign_key: :parent_id
	attr_accessor :blob

end
