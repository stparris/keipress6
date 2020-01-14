class Admin::ImageCropsController < AdminController
  before_action :set_image_crop, only: [:show, :edit, :update, :destroy]

  layout 'admins'

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
    @image_crop = ImageCrop.new
  end

  # GET /image_crops/1/edit
  def edit
    filename = @image_crop.image.filename
      File.open("#{Rails.root}/public/assets/images/#{filename}", "wb") do |f|
      f.write(@image_crop.image.download)
    end  
  end

  # POST /image_crops
  # POST /image_crops.json
  def create
    @image_crop = ImageCrop.new(image_crop_params)

    respond_to do |format|
      if @image_crop.save
        format.html { redirect_to @image_crop, notice: 'Image crop was successfully created.' }
        format.json { render :show, status: :created, location: @image_crop }
      else
        format.html { render :new }
        format.json { render json: @image_crop.errors, status: :unprocessable_entity }
      end
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
    @image_crop.image.purge
    @image_crop.image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: "#{filename}", content_type: "#{content_type}") 
    @image_crop.save
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")

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
    def set_image_crop
      @image_crop = ImageCrop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_crop_params
      params.require(:image).permit(:blob)
    end
end
