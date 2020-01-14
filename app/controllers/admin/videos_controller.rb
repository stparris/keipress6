class Admin::VideoController < AdminController
  before_action :set_video, only: [:show, :edit, :upload, :update, :destroy]

  layout 'admins'

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  def upload
  end  

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    respond_to do |format|
      if @image.save
        flash[:success] = 'Image was successfully created.'
        format.html { redirect_to admin_image_url(@image) }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      begin
        if @image.update(image_params)
          flash[:success] = 'Image was successfully updated.'
          format.html { redirect_to admin_image_url(@image) }
          format.json { render :show, status: :ok, location: @image }
        else
          format.html { render :edit }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :edit }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    respond_to do |format|
      begin
        if @image.destroy      
          flash[:success] = 'Image was successfully removed.'
          format.html { redirect_to admin_images_url }
          format.json { head :no_content }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:site_id,:name,:caption,:copyright,:description,:image)
    end
end
