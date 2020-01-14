class Admin::CarouselsController < AdminController
  before_action :set_carousel, only: [:show, :edit, :update, :destroy]
 
  layout 'admins'

  # GET /carousels
  # GET /carousels.json
  def index
        @carousel = nil
    @carousels = @site.carousels
  end

  # GET /carousels/1
  # GET /carousels/1.json
  def show
    @carousel_slides = @carousel.carousel_slides
  end

  # GET /carousels/new
  def new
    @carousel = Carousel.new
    @carousel.site = @site
  end

  # GET /carousels/1/edit
  def edit
  end

  # POST /carousels
  # POST /carousels.json
  def create
    @carousel = Carousel.new(carousel_params)
    respond_to do |format|
      begin
        if @carousel.save
          flash[:success] = ' group was successfully created.'
          format.html { redirect_to admin_carousel_url(@carousel) }
          format.json { render :show, status: :created, location: @carousel }
        else
          format.html { render :new }
          format.json { render json: @carousel.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end        
    end
  end

  # PATCH/PUT /carousels/1
  # PATCH/PUT /carousels/1.json
  def update
    respond_to do |format|
      begin
        if @carousel.update(carousel_params)
          flash[:success] = ' group was successfully updated.'
          if @page
            format.html { redirect_to admin_page_url(@page) }
          else
            format.html { redirect_to admin_carousel_url(@carousel) }
          end
          format.json { render :show, status: :ok, location: @carousel }
        else
          format.html { render :edit }
          format.json { render json: @carousel.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /carousels/1
  # DELETE /carousels/1.json
  def destroy
    respond_to do |format|
      begin  
        if @carousel.destroy
          flash[:success] = ' group was successfully removed.'
          format.html { redirect_to admin_carousels_url }
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
    def set_carousel
      @carousel = Carousel.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @carousel
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carousel_params
      params.require(:carousel).permit(:name,:description,:css_classes,:with_controls,:with_indicators,:with_captions,:with_pause,:with_ride,:interval,:site_id,:image_variant)
    end
end
