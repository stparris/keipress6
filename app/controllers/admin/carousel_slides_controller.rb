class Admin::CarouselSlidesController < AdminController
  before_action :set_carousel_slide, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'
    
  def sort
    params[:carousel_slide].each_with_index do |id, index|
      item = CarouselSlide.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end


  # GET /carousel_slides
  # GET /carousel_slides.json
  def index

  end

  # GET /carousel_slides/1
  # GET /carousel_slides/1.json
  def show
  end

  # GET /carousel_slides/new
  def new
  
  end

  # GET /carousel_slides/1/edit
  def edit
  end

  # POST /carousel_slides
  # POST /carousel_slides.json
  def create
    @carousel_slide = CarouselSlide.new(carousel_slide_params)

    respond_to do |format|
      if @carousel_slide.save
        flash[:success] = 'Carousel slide was successfully created.'
        format.html { redirect_to admin_carousel_slide_url(@carousel_slide) }
        format.json { render :show, status: :created, location: @carousel_slide }
      else
        format.html { render :new }
        format.json { render json: @carousel_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carousel_slides/1
  # PATCH/PUT /carousel_slides/1.json
  def update
    respond_to do |format|
      if @carousel_slide.update(carousel_slide_params)
        flash[:success] = 'Carousel slide was successfully updated.'
        format.html { redirect_to admin_carousel_slide_url(@carousel_slide) }
        format.json { render :show, status: :ok, location: @carousel_slide }
      else
        format.html { render :edit }
        format.json { render json: @carousel_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carousel_slides/1
  # DELETE /carousel_slides/1.json
  def destroy
    @carousel = @carousel_slide.carousel
    @carousel_slide.destroy
    respond_to do |format|
      flash[:success] = 'Carousel slide was successfully deleted.'
      format.html { redirect_to admin_carousel_url(@carousel) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new
      @carousel = Carousel.find(params[:carousel_id])
      @carousel_slide = CarouselSlide.new
    end

    def set_carousel_slide
      @carousel_slide = CarouselSlide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carousel_slide_params
      params.require(:carousel_slide).permit(:name,:caption,:body,:css_classes,:carousel_id,:image_id)
    end
end
