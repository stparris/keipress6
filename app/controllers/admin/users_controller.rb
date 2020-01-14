class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /users
  # GET /users.json
  def index
    if @admin.role == 1
      @users = User.all.order('first_name asc')
    else
      @users = User.where("site_id = ?", @site.id).order('first_name asc')
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      begin
        if @user.save
          
          flash[:success] = 'User was successfully created.'
          format.html { redirect_to admin_user_url(@user) }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      begin
        if @user.update(user_params)
          flash[:success] = 'User was successfully updated.'
          format.html { redirect_to admin_user_url(@user) }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      begin
        if @user.destroy
          flash[:success] = 'User was successfully removed.'
          format.html { redirect_to admin_users_url }
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
    def set_user
      @user = User.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :email,
        :prefix,
        :first_name,
        :middle_name,
        :last_name,
        :suffix,
        :title,
        :new_password,
        :new_password_confirmation,
        :locale,
        :marketing,
        :site_id)
    end
end
