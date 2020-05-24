class Admin::ImagesController < AdminController
  before_action :set_image, only: [:show, :edit, :update, :destroy, :category, :proxy]
  before_action :set_category, only: [:category]

  layout 'admins'

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
    unless @image.image.attached?
      @image_preview = ImagePreview.find_by(image_id: @image.id, preview_type: 'original')
      respond_to do |format|
        if @image_preview
          format.html { redirect_to admin_image_preview_url(@image) }
        else
          format.html { redirect_to new_admin_image_preview_url(image_id: @image.id) }
        end
      end
    end
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  def category
    respond_to do |format|
      format.js do
        if @category
          if @image.categories.include?(@category)
            @image.categories.delete(@category)
          else
            @image.categories << @category
          end
        end
      end
    end
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    respond_to do |format|
      if @image.save
        flash[:success] = 'Image was successfully created.'
        format.html { redirect_to new_admin_image_preview_url(image_id: @image.id) }
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
          format.js
          format.json { render :show, status: :ok, location: @image }
        else
          format.html { render :edit }
          format.js
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
      # @image = Image.find_by(id: params[:id],site_id: @site.id)
      @image = Image.find(params[:id])
      redirect_to admin_errors_url(error_template: '403') unless @image
    end

    def set_category
      @category = params[:category_id].present? ? Category.find(params[:category_id]) : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:site_id,:name,:caption,:copyright_year,:copyright_by,:description,:image,:image_preview_id)
    end
end
