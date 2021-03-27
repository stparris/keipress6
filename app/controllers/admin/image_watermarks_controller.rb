class Admin::ImageWatermarksController < AdminController
  before_action :set_new, only: [:new]
  before_action :set_image_watermark, only: [:edit, :update]

  layout 'admins'

  require 'fileutils'

  # GET /image_watermarks/new
  def new
  end

  # GET /image_watermarks/1/edit
  def edit
  end

  # PATCH/PUT /image_watermarks/1
  # PATCH/PUT /image_watermarks/1.json
  def update
    respond_to do |format|
      begin
        flash[:success] = 'Image optimized.'
        @image_watermark.update(image_watermark_params)
        @image_watermark.make_watermark
        @image_watermark.save
        format.html { redirect_to admin_image_preview_url(@image_watermark.image) }
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :edit }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new
      parent = ImagePreview.find(params[:parent_id])
      # file_name = "#{Rails.root}/public/image_previews/#{parent.preview_type}_#{parent.image_id}.#{parent.file_extention}"
      # watermark_file = "#{Rails.root}/public/image_previews/watermark_#{parent.image_id}.#{parent.file_extention}"
      # FileUtils.cp file_name, watermark_file
      @image_watermark = ImageWatermark.where(
        image_id: parent.image_id,
        preview_type: 'watermark').first_or_create!
      @image_watermark.parent_id = parent.id
      @image_watermark.source_file = parent.source_file
      @image_watermark.content_type = parent.content_type
      @image_watermark.size = parent.size
      @image_watermark.max_width = parent.get_max_width
      # @image_watermark.save
      # @image_url = "/image_previews/watermark_#{parent.image_id}.#{parent.file_extention}"
      # @image_preview = ImagePreview.find_by(image_id: parent.image_id, preview_type: 'original')
      # @image_crop = ImagePreview.find_by(image_id: parent.image_id, preview_type: 'crop')
    end

    def set_image_watermark
      @image_watermark = ImageWatermark.find(params[:id])
      # @image_url = "/image_previews/watermark_#{@image_watermark.image_id}.#{@image_watermark.file_extention}"
      # @image_watermark.max_width = @image_watermark.get_max_width
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_watermark_params
      params.require(:image_watermark).permit(
        :max_width,
        :parent_id,
        :watermark_id,
        :source_file,
        :content_type,
        :size,
        :preview_type,
        :quality)
    end


end
