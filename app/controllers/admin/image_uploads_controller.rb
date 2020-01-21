class Admin::ImageUploadsController < AdminController
  before_action :set_image_upload, only: [:edit, :update]

  layout 'admins'

  # GET /image_uploads/1/edit
  def edit
  end

    def update
    respond_to do |format|
      begin
        @image_upload.update!(image_upload_params)
        @image_upload.max_width = nil
        @image_upload.quality = nil
        @image_upload.save
        flash[:success] = 'Image was successfully uploaded.'
        format.html { redirect_to admin_image_url(@image_upload) }
        format.json { render :show, status: :ok, location: @image_upload }
      rescue ImageUpload::ImageTooBigError, ImageUpload::ImageInvalidTypeError => e
        flash[:danger] = "Error: #{e.message}"
        @image_upload.image.purge
        format.html { render :edit }
        format.json { render json: @image_upload.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /image_uploads/1
  # PATCH/PUT /image_uploads/1.json
  # def update
  #   respond_to do |format|
  #     begin
  #       @image_upload.update!(image_upload_params)
  #       @image_upload.max_width = nil
  #       @image_upload.quality = nil
  #       @image_upload.save
  #       flash[:success] = 'Image was successfully uploaded.'
  #       format.html { redirect_to admin_image_url(@image_upload) }
  #       format.json { render :show, status: :ok, location: @image_upload }
  #     rescue ImageUpload::ImageTooBigError, ImageUpload::ImageInvalidTypeError => e
  #       flash[:danger] = "Error: #{e.message}"
  #       @image_upload.image.purge
  #       format.html { render :edit }
  #       format.json { render json: @image_upload.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_upload
      @image_upload = ImageUpload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_upload_params
      params.require(:image_upload).permit(:site_id,:name,:caption,:copyright_year,:copyright_by,:description,:image,:quality,:max_width)
    end
end
