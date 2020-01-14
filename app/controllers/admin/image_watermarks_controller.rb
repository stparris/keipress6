class Admin::ImageWatermarksController < AdminController
  before_action :set_image_watermark, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /image_watermarks
  # GET /image_watermarks.json
  def index
    @image_watermarks = ImageWatermark.all
  end

  # GET /image_watermarks/1
  # GET /image_watermarks/1.json
  def show
  end

  # GET /image_watermarks/new
  def new
    @image_watermark = ImageWatermark.new
  end

  # GET /image_watermarks/1/edit
  def edit
  end

  # POST /image_watermarks
  # POST /image_watermarks.json
  def create
    @image_watermark = ImageWatermark.new(image_watermark_params)

    respond_to do |format|
      if @image_watermark.save
        format.html { redirect_to @image_watermark, notice: 'Image watermark was successfully created.' }
        format.json { render :show, status: :created, location: @image_watermark }
      else
        format.html { render :new }
        format.json { render json: @image_watermark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_watermarks/1
  # PATCH/PUT /image_watermarks/1.json
  def update

    filename = @image_watermark.image.filename
    content_type = @image_watermark.image.content_type
    File.open("#{Rails.root}/tmp/#{filename}", "wb") do |f|
      f.write(params[:image][:blob].read)
    end  

    MiniMagick::Tool::Magick.new do |magick|
      magick << "#{Rails.root}/tmp/#{filename}"
      magick.resize("100x100")
      magick.negate
      magick << "#{Rails.root}/tmp/test_#{filename}"
    end

=begin
    @image_watermark.image.purge
    @image_watermark.image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: "#{filename}", content_type: "#{content_type}") 
    @image_watermark.save
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
=end

    respond_to do |format|
      if @image_watermark.update(image_watermark_params)
        format.html { redirect_to @image_watermark, notice: 'Image watermark was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_watermark }
      else
        format.html { render :edit }
        format.json { render json: @image_watermark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_watermarks/1
  # DELETE /image_watermarks/1.json
  def destroy
    @image_watermark.destroy
    respond_to do |format|
      format.html { redirect_to image_watermarks_url, notice: 'Image watermark was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_watermark
      @image_watermark = ImageWatermark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_watermark_params
      params.require(:image).permit(:site_id,:name,:caption,:copyright,:description)
    end
end
