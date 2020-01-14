class Admin::ThemesController < AdminController
  before_action :set_theme, except: [:new, :create, :index]

  layout 'admins'

  # GET /themes
  # GET /themes.json
  def index
        @themes = Theme.where(site_id: @site.id).order('name asc')
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
  end

  # GET /themes/new
  def new
    @theme = Theme.new
  end

  # GET /themes/1/edit
  def edit
  end

  def edit_scss_production
  end
  
  def edit_scss_workspace
  end   
  
  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(theme_params)
    respond_to do |format|
      if @theme.save
        flash[:success] = 'Theme was successfully created.' 
        format.html { redirect_to admin_theme_url(@theme) }
        format.json { render :show, status: :created, location: @theme }
      else
        flash[:danger] = 'Theme was successfully created.' 
        format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    @attribute = nil
    @message = nil
    respond_to do |format|
      now = Time.now.strftime("%Y-%m-%d %H:%M")
      format.js do 
        @theme.update(theme_params)
      end
      format.html do
        if @theme.update!(theme_params)
          flash[:success] = 'Theme was successfully updated.' 
          redirect_to admin_theme_url(@theme)
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    @theme.destroy
    respond_to do |format|
      flash[:success] = 'Theme was successfully deleted.' 
      format.html { redirect_to themes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @theme
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:site_id,:name,:css_class,:new_scss_production,:new_scss_workspace)
    end
end
