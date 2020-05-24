require "image_processing/vips"
require 'fileutils'

class ImageOptimization < ImagePreview
  belongs_to :image_preview, class_name: 'ImagePreview', foreign_key: :parent_id, optional: true

  def optimize
    optimize_file = "#{Rails.root}/public/image_previews/optimize_#{self.image_id}.#{self.file_extention}"
    temp_file = "#{Rails.root}/public/image_previews/optimize_#{self.image_id}_#{rand(1000000)}.#{self.file_extention}"
    FileUtils.cp optimize_file, temp_file
    if self.quality == 100
      ImageProcessing::Vips
        .source(optimize_file)
        .resize_to_limit(self.max_width.to_i,self.max_width.to_i)
        .saver(strip: true)
        .call(destination: temp_file)
    else
      ImageProcessing::Vips
        .source(optimize_file)
        .resize_to_limit(self.max_width.to_i,self.max_width.to_i)
        .saver(strip: true)
        .saver(quality: self.quality)
        .call(destination: temp_file)
    end
    self.size = File.new(temp_file).size
    FileUtils.rm(optimize_file)
    FileUtils.mv temp_file, optimize_file
  end

end
