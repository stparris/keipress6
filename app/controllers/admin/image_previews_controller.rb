class Admin::ImagePreviewsController < AdminController
  before_action :set_image_preview, only: [:new, :edit, :create, :update]

  layout 'admins'

  # GET /image_previews/1/edit
  def edit
  end

  def new
  end


  def update
    respond_to do |format|
      begin
        # @image_preview.update!(image_preview_params)
        # @image_preview.max_width = nil
        # @image_preview.quality = nil
        # @image_preview.save
        flash[:success] = 'Image was successfully previewed.'
        format.html { redirect_to admin_image_url(@image_preview) }
        format.json { render :show, status: :ok, location: @image_preview }
      rescue ImagePreview::ImageTooBigError, ImagePreview::ImageInvalidTypeError => e
        flash[:danger] = "Error: #{e.message}"
        format.html { render :edit }
        format.json { render json: @image_preview.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    respond_to do |format|
      begin
        @image_preview = ImagePreview.new(image_preview_params)
        previewed_file = @image_preview.upload_file
        @image_preview.file_name = previewed_file.original_filename
        @image_preview.file_type = previewed_file.content_type.sub(/image\//,'').sub(/jpeg/,'jpg')
        @image_preview.preview_type = 'original'
        temp_file_name = "#{Rails.root}/public/image_previews/original_#{rand(6)}_#{previewed_file.original_filename}"
        File.open(temp_file_name, 'wb') do |file|
          file.write(previewed_file.read)
        end
        @image_preview.file_size = File.new(temp_file_name).size
        @image_preview.save!
        FileUtils.mv temp_file_name, "#{Rails.root}/public/image_previews/original_#{@image_preview.id}.#{@image_preview.file_type}"
        format.js
      rescue ImagePreview::ImageTooBigError, ImagePreview::ImageInvalidTypeError => e
        @message = "Error: #{e.message}"
        format.js { render :new }
      ensure
        FileUtils.rm temp_file_name if File.exists?(temp_file_name)
      end
    end
  end


  # PATCH/PUT /image_previews/1
  # PATCH/PUT /image_previews/1.json
  # def update
  #   respond_to do |format|
  #     begin
  #       @image_preview.update!(image_preview_params)
  #       @image_preview.max_width = nil
  #       @image_preview.quality = nil
  #       @image_preview.save
  #       flash[:success] = 'Image was successfully previewed.'
  #       format.html { redirect_to admin_image_url(@image_preview) }
  #       format.json { render :show, status: :ok, location: @image_preview }
  #     rescue ImagePreview::ImageTooBigError, ImagePreview::ImageInvalidTypeError => e
  #       flash[:danger] = "Error: #{e.message}"
  #       @image_preview.image.purge
  #       format.html { render :edit }
  #       format.json { render json: @image_preview.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_preview
      @image_preview = ImagePreview.new
      @image = params[:image_id].present? ? Image.find(params[:image_id]) : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_preview_params
      params.require(:image_preview).permit(:site_id,:image_id,:file_name,:upload_file)
    end
end
