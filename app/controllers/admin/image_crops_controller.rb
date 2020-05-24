class Admin::ImageCropsController < AdminController
  before_action :set_image_crop, only: [:edit, :update]
  before_action :set_new, only: [:new]

  layout 'admins'

  require 'fileutils'

  # GET /image_crops/new
  def new
  end

  # GET /image_crops/1/edit
  def edit
  end

  # PATCH/PUT /image_crops/1
  # PATCH/PUT /image_crops/1.json
  def update
    return_doc = {}
    return_doc['success'] = 'true'
    respond_to do |format|
      begin
        crop_file = "#{Rails.root}/public/image_previews/crop_#{@image_crop.image_id}.#{@image_crop.file_extention}"
        File.open(crop_file, "wb") do |f|
          f.write(params[:image][:blob].read)
        end
        @image_crop.size = File.new(crop_file).size
        @image_crop.source_file = @image_crop.image_preview.source_file
        @image_crop.content_type = @image_crop.image_preview.content_type
        @image_crop.save!
        format.json { render status: 200, json: return_doc.to_json }
      rescue Exception => e
        return_doc['error'] = "Oops! #{e.message}"
        format.json { render status: 500, json: return_doc.to_json }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new
      @image_preview = ImagePreview.find(params[:parent_id])
      file_name = "#{Rails.root}/public/image_previews/original_#{@image_preview.image_id}.#{@image_preview.file_extention}"
      crop_file = "#{Rails.root}/public/image_previews/crop_#{@image_preview.image_id}.#{@image_preview.file_extention}"
      FileUtils.cp file_name, crop_file
      @image_crop = ImageCrop.where(
        image_id: @image_preview.image_id,
        parent_id: @image_preview.id,
        preview_type: 'crop',
        ).first_or_create
      @image_crop.source_file = @image_preview.source_file
      @image_crop.content_type = @image_preview.content_type
      @image_crop.size = @image_preview.size
      @image_crop.max_width = @image_preview.get_max_width
      @image_url = "/image_previews/crop_#{@image_crop.image_id}.#{@image_crop.file_extention}"
      @image_crop.save
    end

    def set_image_crop
      @image_crop = ImageCrop.find(params[:id])
      @image_url = "/image_previews/crop_#{@image_crop.image_id}.#{@image_crop.file_extention}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_crop_params
      params.require(:image_crop).permit(:image_id,:parent_id,:blob)
    end
end
