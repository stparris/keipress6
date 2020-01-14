class Admin::NavigationsController < AdminController
  before_action :set_navigation, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new] 

  layout 'admins'

  # GET /navigations
  # GET /navigations.json
  def index
    @navigations = @site.navigations
  end

  # GET /navigations/1
  # GET /navigations/1.json
  def show
    @navigation_items = @navigation.navigation_items
  end

  # GET /navigations/new
  def new
  end

  # GET /navigations/1/edit
  def edit
  end

  # POST /navigations
  # POST /navigations.json
  def create
    @navigation = Navigation.new(navigation_params)
    respond_to do |format|
      if @navigation.save
        flash[:success] = 'Navigation was successfully created.'  
        format.html { redirect_to admin_navigation_url(@navigation) }
        format.json { render :show, status: :created, location: @navigation }
      else
        format.html { render :new }
        format.json { render json: @navigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /navigations/1
  # PATCH/PUT /navigations/1.json
  def update
    respond_to do |format|
      if @navigation.update(navigation_params)
        flash[:success] =  'Navigation was successfully updated.'
        if @page
          format.html { redirect_to admin_page_url(@page) }
        else
          format.html { redirect_to admin_navigation_url(@navigation) }
        end
        format.json { render :show, status: :ok, location: @navigation }
      else
        format.html { render :edit }
        format.json { render json: @navigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /navigations/1
  # DELETE /navigations/1.json
  def destroy
    @navigation.destroy
        respond_to do |format|
      flash[:success] = 'Navigation was successfully deleted.' 
      format.html { redirect_to admin_navigations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_navigation
      @navigation = Navigation.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @navigation
    end

    def set_new
      @navigation = Navigation.new
      @navigation.nav_type = params[:nav_type].present? ? params[:nav_type] : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def navigation_params
      params.require(:navigation).permit(:name,:site_id,:nav_type,:main_css_classes,:list_css_classes,:brand,:form)
    end
end
