class Admin::PalettesController < AdminController
  before_action :set_palette, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /palettes
  # GET /palettes.json
  def index
        @palettes = Palette.all
  end

  # GET /palettes/1
  # GET /palettes/1.json
  def show
  end

  # GET /palettes/new
  def new
    @palette = Palette.new
  end

  # GET /palettes/1/edit
  def edit
  end

  # POST /palettes
  # POST /palettes.json
  def create
    @palette = Palette.new(palette_params)

    respond_to do |format|
      if @palette.save
        i = 1
        params[:color_list].split(/,/).each do |color|
          PaletteColor.create(palette_id: grayscale.id, name: "#{@palette.name}#{i < 10 ? '0'+i.to_s : i}",value: color)
          i += 1
        end
        flash[:success] = 'Palette was successfully created.'
        format.html { redirect_to admin_palette_url(@palette) }
        format.json { render :show, status: :created, location: @palette }
      else
        format.html { render :new }
        format.json { render json: @palette.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /palettes/1
  # PATCH/PUT /palettes/1.json
  def update
    respond_to do |format|
      if @palette.update(palette_params)
        flash[:success] = 'Palette was successfully updated.' 
        format.html { redirect_to admin_palette_url(@palette) }
        format.json { render :show, status: :ok, location: @palette }
      else
        format.html { render :edit }
        format.json { render json: @palette.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /palettes/1
  # DELETE /palettes/1.json
  def destroy
    @palette.destroy
    respond_to do |format|
      flash[:success] = 'Palette was successfully deleted.'
      format.html { redirect_to admin_palettes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_palette
      @palette = Palette.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def palette_params
      params.require(:palette).permit(:name, :color_list)
    end
end
