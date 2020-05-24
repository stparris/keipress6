class Admin::ImagePreviewsController < AdminController
  before_action :set_new, only: [:new]
  before_action :set_image_preview, only: [:update, :destroy]
  before_action :set_show, only: [:show]

  layout 'admins'

  # GET /image_previews/1/edit
  def new
  end

  def show

  end

  def update
    file_name = ""
    respond_to do |format|
      previewed_file = params[:image_preview][:upload_file]
      @image_preview.source_file = previewed_file.original_filename
      @image_preview.content_type = previewed_file.content_type
      @image_preview.preview_type = 'original'
      file_name = "#{Rails.root}/public/image_previews/original_#{@image_preview.image_id}.#{@image_preview.file_extention}"
      FileUtils.rm Dir.glob("#{Rails.root}/public/image_previews/*_#{@image.id}.*")
      ImageCrop.where(image_id: @image.id, preview_type: 'crop').delete_all
      ImageOptimization.where(image_id: @image.id, preview_type: 'optimize').delete_all
      begin
        File.open(file_name, 'wb') do |file|
          file.write(previewed_file.read)
        end
        @image_preview.save!
        format.html { redirect_to admin_image_preview_url(@image_preview.image) }
      rescue ImagePreview::ImageTooBigError, ImagePreview::ImageInvalidTypeError => e
        @message = "Error: #{e.message}"
        FileUtils.rm file_name if File.exists?(file_name)
        format.html { render :show }
      end
    end
  end

  def destroy
    respond_to do |format|
      FileUtils.rm Dir.glob("#{Rails.root}/public/image_previews/*_#{@image.id}.*")
      ImagePreview.where(image_id: @image.id).delete_all
      format.html { redirect_to admin_image_url(@image) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_preview
      @image_preview = ImagePreview.find(params[:id])
      @image = @image_preview.image
    end

    def set_new
      @image = params[:image_id].present? ? Image.find(params[:image_id]) : nil
      @image_preview = ImagePreview.where(image_id: @image.id, preview_type: 'original').first_or_create
    end

    def set_show
      @image = Image.find(params[:id])
      @image_preview = ImagePreview.find_by(image_id: @image.id, preview_type: 'original')
      @image_crop = ImageCrop.find_by(image_id: @image.id, preview_type: 'crop')
      @image_optimization = ImageOptimization.find_by(image_id: @image.id, preview_type: 'optimize')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_preview_params
      params.require(:image_preview).permit(:image_id,:upload_file)
    end
end
