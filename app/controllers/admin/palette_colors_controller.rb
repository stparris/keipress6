class Admin::PaletteColorsController < AdminController
  before_action :set_palette_color, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  # GET /palette_colors
  # GET /palette_colors.json
  def index
        @palette_colors = PaletteColor.all
  end

  # GET /palette_colors/1
  # GET /palette_colors/1.json
  def show
  end

  # GET /palette_colors/new
  def new
    @palette_color = PaletteColor.new
  end

  # GET /palette_colors/1/edit
  def edit
  end

  # POST /palette_colors
  # POST /palette_colors.json
  def create
    @palette_color = PaletteColor.new(palette_color_params)
    respond_to do |format|
      if @palette_color.save
        flash[:success] = 'Palette color was successfully created.'
        format.html { redirect_to @palette_color }
        format.json { render :show, status: :created, location: @palette_color }
      else
        format.html { render :new }
        format.json { render json: @palette_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /palette_colors/1
  # PATCH/PUT /palette_colors/1.json
  def update
    respond_to do |format|
      if @palette_color.update(palette_color_params)
        flash[:success] = 'Palette color was successfully updated.' 
        format.html { redirect_to @palette_color }
        format.json { render :show, status: :ok, location: @palette_color }
      else
        format.html { render :edit }
        format.json { render json: @palette_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /palette_colors/1
  # DELETE /palette_colors/1.json
  def destroy
    @palette = palette_color.palette
    @palette_color.destroy
    respond_to do |format|
      flash[:success] = 'Palette color was successfully deleted.'
      format.html { redirect_to admin_palette_url(@palette)  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new
      @palette = Palette.find(params[:palette_id])
      @palette_color = PaletteColor.new
    end

    def set_palette_color
      @palette_color = PaletteColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def palette_color_params
      params.require(:palette_color).permit(:palette_id,:name,:value)
    end
end
