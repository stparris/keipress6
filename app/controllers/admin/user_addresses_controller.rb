class Admin::UserAddressesController < AdminController
  before_action :set_user_address, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new]

  layout 'admins'

  # GET /Useraddress/1
  # GET /Useraddress/1.json
  def show
  end

  # GET /Useraddress/new
  def new
    @user_address = UserAddress.new
    @user_address.user = @user
  end

  # GET /Useraddress/1/edit
  def edit
  end

  # POST /Useraddress
  # POST /Useraddress.json
  def create
    @user_address = UserAddress.new(user_address_params)
    @user = @user_address.user
    respond_to do |format|
      if @user_address.save
        flash[:success] = 'User address was successfully created.'
        format.js
        format.html { redirect_to admin_user_address_url(@user_address) }
        format.json { render :show, status: :created, location: @user_address }
      else
        format.html { render :new }
        format.json { render json: @user_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Useraddress/1
  # PATCH/PUT /Useraddress/1.json
  def update
    respond_to do |format|
      if @user_address.update(user_address_params)
        flash[:success] = 'User address was successfully updated.'
        format.js
        format.html { redirect_to admin_user_address_url(@user_address) }
        format.json { render :show, status: :ok, location: @user_address }
      else
        format.html { render :edit }
        format.json { render json: @user_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Useraddress/1
  # DELETE /Useraddress/1.json
  def destroy
    @user = @user_address.user
    @user_address.destroy
    respond_to do |format|
      flash[:success] = 'User address was successfully deleted.'
      format.js
      format.html { redirect_to admin_user_url(@user) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_address
      @user_address = UserAddress.find(params[:id])
      @user = @user_address.user
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_address_params
      params.require(:user_address).permit(
        :user_id,
        :name,
        :address1,
        :address2,
        :city,
        :post_code,
        :phone,
        :alternative_phone,
        :state_id,
        :country_id)
    end
end
