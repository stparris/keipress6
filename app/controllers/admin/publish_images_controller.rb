class Admin::PublishImagesController < AdminController
  before_action :set_image, only: [:show, :create]
  before_action :set_image_preview, only: [:create]

  layout 'admins'

  def show

  end

  def create
    respond_to do |format|
      begin
        @image_publish.image.purge if @image_publish.image.attached?
        preview_file = "#{Rails.root}/image_previews/#{@image_preview.preview_type}_#{@image_preview.id}.#{@image_preview.image_type}"
        @image_crop.image.attach(io: File.open(preview_file), filename: "#{@image_preview.file_name}", content_type: "image/#{@image_preview.image_type}")
        @image_crop.save
        flash[:success] = 'Image was successfully published.'
        format.html { redirect_to admin_image_publish_url(@image_publish) }
      rescue Exception => e
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { redirect_to admin_image_url(@image_publish) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_preview
      @image_preview = ImagePreview.find(params[:publish_image][:image_preview_id])
    end

    def set_image
      @image_publish = ImagePublish.find(params[:id])
      redirect_to admin_errors_url(error_template: '403') unless @image
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:image_preview_id)
    end
