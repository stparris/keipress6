require 'fileutils'

class ImagePublish < ImagePreview

  def publish
    self.image.image.purge if self.image.image.attached?
    file_name = "#{Rails.root}/public/image_previews/#{self.preview_type}_#{self.image.id}.#{self.file_extention}"
    self.image.image.attach(io: File.open(file_name), filename: "#{self.source_file}", content_type: "#{self.content_type}")
    FileUtils.rm Dir.glob("#{Rails.root}/public/image_previews/*_#{self.image.id}.*")
    ImagePreview.where(image_id: self.image.id).delete_all
  end

end
