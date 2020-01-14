class Admin::ThemeColorsController < AdminController
  before_action :set_theme_color, only: [:show, :edit, :update, :destroy]
  before_action :set_theme, only: [:index]

  # GET /theme_colors
  # GET /theme_colors.json
  def index
        @theme_colors = ThemeColor.all
  end

  # GET /theme_colors/1
  # GET /theme_colors/1.json
  def show
  end

  # GET /theme_colors/new
  def new
    @theme_color = ThemeColor.new
  end

  # GET /theme_colors/1/edit
  def edit
  end

  # POST /theme_colors
  # POST /theme_colors.json
  def create
    @theme_color = ThemeColor.find_or_create_by!(theme_color_params)
    @theme = @theme_color.theme
    respond_to do |format|
      format.js
      format.html do 
        flash[:success] = 'Theme color was successfully created.'
        redirect_to admin_theme_url(@theme) 
      end
      format.json { render :show, status: :created, location: @theme_color }
    end
  end

  # PATCH/PUT /theme_colors/1
  # PATCH/PUT /theme_colors/1.json
  def update
    return_doc = {}
    return_doc['success'] = 'true'
    respond_to do |format|
      if @theme_color.update(theme_color_params)
        format.js { render layout: false, content_type: 'text/javascript' }
        format.json do
          return_doc['color_value'] = @theme_color.value
          return_doc['color_name'] = @theme_color.name
          render json: return_doc.to_json
        end
        format.html do
          flash[:success] = 'Theme color was successfully updated.'
          redirect_to admin_theme_url(@theme) 
        end
      else
        format.json do
          return_doc['success'] = 'error'
          render json: return_doc.to_json
        end
        format.html { render :edit }
      end
    end
  end

  # DELETE /theme_colors/1
  # DELETE /theme_colors/1.json
  def destroy
    @theme = @theme_color.theme
    @theme_color.destroy
    respond_to do |format|
      format.js
      format.html do 
        flash[:success] = 'Theme color was successfully deleted.' 
        redirect_to admin_theme_url(@theme) 
      end
      format.json { head :no_content }
    end
  end

  private
    def set_theme
      @theme = Theme.find(params[:theme_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_theme_color
      @theme_color = ThemeColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_color_params
      params.require(:theme_color).permit(:theme_id,:palette_color_id,:name,:value)
    end
end
