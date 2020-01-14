class Admin::DropdownsController < AdminController
  before_action :set_dropdown, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new] 

  layout 'admins'

  # GET /dropdowns
  # GET /dropdowns.json
  def index
    @dropdowns = @site.dropdowns
  end

  # GET /dropdowns/1
  # GET /dropdowns/1.json
  def show
    @dropdown_items = @dropdown.dropdown_items
  end

  # GET /dropdowns/new
  def new
  end

  # GET /dropdowns/1/edit
  def edit
  end

  # POST /dropdowns
  # POST /dropdowns.json
  def create
    @dropdown = Dropdown.new(dropdown_params)
    respond_to do |format|
      if @dropdown.save
        flash[:success] = 'Dropdown was successfully created.'  
        format.html { redirect_to admin_dropdown_url(@dropdown) }
        format.json { render :show, status: :created, location: @dropdown }
      else
        format.html { render :new }
        format.json { render json: @dropdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dropdowns/1
  # PATCH/PUT /dropdowns/1.json
  def update
    respond_to do |format|
      if @dropdown.update(dropdown_params)
        flash[:success] =  'Dropdown was successfully updated.'
        format.html { redirect_to admin_dropdown_url(@dropdown) }
        format.json { render :show, status: :ok, location: @dropdown }
      else
        format.html { render :edit }
        format.json { render json: @dropdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dropdowns/1
  # DELETE /dropdowns/1.json
  def destroy
    @dropdown.destroy
    respond_to do |format|
      flash[:success] = 'Dropdown was successfully deleted.' 
      format.html { redirect_to admin_dropdowns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dropdown
      @dropdown = Dropdown.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @dropdown
    end

    def set_new
      @dropdown = Dropdown.new
      @dropdown.nav_type = params[:nav_type].present? ? params[:nav_type] : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dropdown_params
      params.require(:dropdown).permit(:name,:site_id,:nav_type,:css_classes)
    end
end
