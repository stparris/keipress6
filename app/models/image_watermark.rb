require "image_processing/vips"
require 'fileutils'

class ImageWatermark < ImagePreview

  belongs_to :image_preview, class_name: 'ImagePreview', foreign_key: :parent_id, optional: true
  belongs_to :watermark, optional: true

  attr_accessor :vips_im, :vips_wm, :x_coord, :y_coord

  def set_coordinates
    case self.watermark.orientation
    when 'south-east'
      self.x_coord = self.vips_im.width - self.vips_wm.width - self.watermark.margin.to_i
      self.y_coord = (self.vips_wm.height - self.vips_im.height).abs - self.watermark.margin.to_i
    when 'south-west'
      self.x_coord = self.watermark.margin.to_i
      self.y_coord = (self.vips_wm.height - self.vips_im.height).abs - self.watermark.margin.to_i
    when 'north-west'
      self.x_coord = self.watermark.margin.to_i
      self.y_coord = self.watermark.margin.to_i
    when 'north-east'
      self.x_coord = self.vips_im.width - self.vips_wm.width - self.watermark.margin.to_i
      self.y_coord = self.watermark.margin.to_i
    else
      self.x_coord = (self.vips_im.width/2 - self.vips_wm.width/2).to_i - self.watermark.margin.to_i
      self.y_coord = (self.vips_im.height/2 - self.vips_wm.height/2).to_i - self.watermark.margin.to_i
    end
  end

  def opacity_value
    case self.watermark.opacity
    when 'low'
      0.7
    when 'medium'
      0.5
    when 'default'
      0.3
    when 'high'
      0.1
    when 'none'
      1
    end
  end

  def text_size
    case self.watermark.size
    when 'x-large'
      self.vips_im.width / 2
    when 'medium'
      self.vips_im.width / 6
    when 'small'
      self.vips_im.width / 8
    when 'x-small'
      self.vips_im.width / 10
    when 'xx-small'
      self.vips_im.width / 12
    else
      self.vips_im.width / 3
    end
  end

  def rotate_wm
    case self.watermark.rotate
    when 'left'
      self.vips_wm = self.vips_wm.rotate(-45)
    when 'right'
      self.vips_wm = self.vips_wm.rotate(45)
    end
  end

  def replicate_text
    color_arr = self.watermark.color.split(/,/)
    a = color_arr[0].to_i
    b = color_arr[1].to_i
    c = color_arr[2].to_i
    self.vips_wm = self.vips_wm.gravity orientation, size, size
    self.vips_wm = self.vips_wm.replicate 1 + self.vips_im.width / self.vips_wm.width, 1 + self.vips_im.height / self.vips_wm.height
    overlay = (self.vips_wm.new_from_image [a,b,c]).copy interpretation: :srgb
    overlay = overlay.bandjoin self.vips_wm
    new_image = self.vips_im.composite overlay, :over
    new_image.write_to_file out
  end

  def composite_resize
    case self.watermark.size
    when 'medium'
      (self.vips_im.width/2).to_i if (self.vips_im.width/2).to_i < self.vips_wm.width
    when 'small'
      (self.vips_im.width/4).to_i if (self.vips_im.width/4).to_i < self.vips_wm.width
    when 'x-small'
      (self.vips_im.width/6).to_i if (self.vips_im.width/6).to_i < self.vips_wm.width
    when 'xx-small'
      (self.vips_im.width/8).to_i if (self.vips_im.width/8).to_i < self.vips_wm.width
    else
      self.vips_im.width - self.watermark.margin.to_i * 2 if self.vips_im.width < self.vips_wm.width
    end
  end

  def make_watermark
    source_file = "#{Rails.root}/public/image_previews/#{self.image_preview.preview_type}_#{self.image_id}.#{self.file_extention}"
    temp_file = "#{Rails.root}/public/image_previews/watermark_#{self.image_id}_#{rand(1000000)}.#{self.file_extention}"
    self.vips_im = Vips::Image.new_from_file source_file, access: :sequential
    if self.watermark.watermark_type == 'composite'
      wm_file = "#{Rails.root}/public/image_previews/wm_file_#{self.image_id}.png"
      File.open(wm_file, "wb") do |f|
        f.write(self.watermark.image.download)
      end
      self.vips_wm = Vips::Image.new_from_file(wm_file)
      self.vips_wm = self.vips_wm.thumbnail_image(self.composite_resize)
      self.set_coordinates
      composite_image = self.vips_im.composite2(self.vips_wm, :over, x: self.x_coord, y: self.y_coord)
      composite_image.write_to_file temp_file
      FileUtils.rm wm_file
    else
      text_mask = Vips::Image.text self.watermark.text, dpi: self.text_size
      height = self.watermark.rotate == 'none' ? text_mask.height : text_mask.width*2
      self.vips_wm = Vips::Image.text self.watermark.text, width: text_mask.width, height: height, dpi: self.text_size, font: self.watermark.font
      self.rotate_wm
      self.vips_wm = (vips_wm * self.opacity_value).cast(:uchar)
      color_arr = self.watermark.color.split(/,/)
      a = color_arr[0].to_i
      b = color_arr[1].to_i
      c = color_arr[2].to_i
      if self.watermark.watermark_type == 'repeat'
        self.vips_wm = self.vips_wm.gravity self.watermark.orientation, self.text_size, self.text_size
        self.vips_wm = self.vips_wm.replicate 1 + self.vips_im.width / self.vips_wm.width, 1 + self.vips_im.height / self.vips_wm.height
        overlay = (self.vips_wm.new_from_image [a,b,c]).copy interpretation: :srgb
        overlay = overlay.bandjoin self.vips_wm
        new_image = self.vips_im.composite overlay, :over
        new_image.write_to_file temp_file
      else
        self.set_coordinates
        overlay = (self.vips_wm.new_from_image [a,b,c]).copy interpretation: :srgb
        overlay = overlay.bandjoin self.vips_wm
        new_image = self.vips_im.composite2(overlay, :over, x: self.x_coord, y: self.y_coord)
        new_image.write_to_file temp_file
      end
    end
    watermark_file = "#{Rails.root}/public/image_previews/watermark_#{self.image_id}.#{self.file_extention}"
    self.size = File.new(temp_file).size
    FileUtils.mv temp_file, watermark_file
    self.save
  end

end
