class Admin::ImageCropsController < AdminController
  before_action :set_image_crop, only: [:edit, :update, :destroy]

  layout 'admins'

  require 'fileutils'

  # GET /image_crops
  # GET /image_crops.json
  def index
    @image_crops = ImageCrop.all
  end

  # GET /image_crops/1
  # GET /image_crops/1.json
  def show
    filename = @image_crop.image.filename
      File.open("#{Rails.root}/assets/images/#{filename}", "wb") do |f|
      f.write(@image_crop.image.download)
    end
  end

  # GET /image_crops/new
  def new

  end

  # GET /image_crops/1/edit
  def edit
    # filename = @image_crop.image.filename
    #   File.open("#{Rails.root}/public/assets/images/#{filename}", "wb") do |f|
    #   f.write(@image_crop.image.download)
    # end
  end

  # POST /image_crops
  # POST /image_crops.json
  def create
    respond_to do |format|
      # begin
        @image_crop = ImageCrop.new(image_crop_params)
        @original_image = @image_crop.image.image_previews.where(preview_type: 'original').first
        @image_crop.parent_id = @original_image.id
        @image_crop.preview_type = 'crop'
        @image_crop.file_name = @original_image.file_name
        @image_crop.file_type = @original_image.file_type
        @image_crop.save
        original_file = "#{Rails.root}/public/image_previews/original_#{@original_image.id}.#{@original_image.file_type}"
        crop_file = "#{Rails.root}/public/image_previews/crop_#{@image_crop.id}.#{@image_crop.file_type}"
        FileUtils.cp original_file, crop_file
        format.html { redirect_to edit_admin_image_crop_url(@image_crop) }
      # rescue
      #   format.html { redirect_to admin_image_preview_url(@original_image)}
      # end
    end
  end

  # PATCH/PUT /image_crops/1
  # PATCH/PUT /image_crops/1.json
  def update
    filename = @image_crop.image.filename
    content_type = @image_crop.image.content_type
    File.open("#{Rails.root}/tmp/#{filename}", "wb") do |f|
      f.write(params[:image][:blob].read)
    end

  end

  # DELETE /image_crops/1
  # DELETE /image_crops/1.json
  def destroy
    @image_crop.destroy
    respond_to do |format|
      format.html { redirect_to image_crops_url, notice: 'Image crop was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = params[:image_id].present? ? Image.find(params[:image_id]) : nil
    end

    def set_original_image

    end

    def set_image_crop
      @image_crop = ImageCrop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_crop_params
      params.require(:image_crop).permit(:image_id,:parent_id,:blob)
    end
end
