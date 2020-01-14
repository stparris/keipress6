class Admin::AdminsController < AdminController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /admins
  # GET /admins.json
  def index
    @admins = @admin.role == 1 ? Admin.order(first_name: 'asc') : Admin.joins(:admins_sites).where("site_id = ?", @site.id).order('first_name asc')
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin_obj = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin_obj = Admin.new(admin_params)
    @admin_obj.parent_admin = @admin
    respond_to do |format|
      begin
        @admin_obj.save!
        flash[:success] = 'Admin was successfully created.'
        format.html { redirect_to admin_admin_url(@admin_obj) }
        format.json { render :show, status: :created, location: @admin_obj }
      rescue Exception => e 
        flash[:danger] = "Error: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      begin
        @admin_obj.update!(admin_params)
        flash[:success] = 'Admin was successfully updated.'
        format.html { redirect_to admin_admin_url(@admin_obj) }
        format.json { render :show, status: :ok, location: @admin_obj }
      rescue Exception => e 
        flash[:danger] = "Error: #{e.message}"
        format.html { render :edit }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    respond_to do |format|
      begin
        @admin_obj.destroy
        flash[:success] = 'Admin was successfully removed.'
        format.html { redirect_to admin_admins_url }
        format.json { head :no_content }
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin_obj = Admin.find(params[:id])
      @admin_obj.parent_admin = @admin
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(
          :email,
          :prefix,
          :first_name,
          :middle_name,
          :last_name,
          :suffix,
          :title,
          :phone,
          :bio,
          :new_password,
          :new_password_confirmation,
          :status,
          :role,
          :admin_token)
    end
end
