class UsersController < ProductionController
  before_action :set_user

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @address = UserAddress.new
    return_doc = {}
    return_doc['success'] = 'false'
    return_doc['user_persisted'] = false
    respond_to do |format|
      format.json do
        begin
          if @user.persisted?
            return_doc['user_persisted'] = true
            return_doc['email'] = @user.email
            return_doc['prefix'] = @user.prefix
            return_doc['first_name'] = @user.first_name
            return_doc['middle_name'] = @user.middle_name
            return_doc['last_name'] = @user.last_name
            return_doc['suffix'] = @user.suffix
            return_doc['title'] = @user.title
            return_doc['marketing'] = @user.marketing
            return_doc['addresses'] = []
            @user.user_addresses.each do |address|
              add_name = address.name == 'Default' ? 'user_address' : "user_address_#{address.name}"
              add = {}
              add['name'] = address.name
              add[add_name] = address.name
              add["address1"] = address.address1
              add["address2"] = address.address2
              add["city"] = address.city
              add["post_code"] = address.post_code
              add["phone"] = address.phone
              add["alternative_phone"] = address.alternative_phone
              add["state_id"] = address.state_id
              add["country_id"] = address.country_id
              return_doc['addresses'] << add
            end
          else
            return_doc['success'] = true
          end
          return_doc['success'] = true
          render json: return_doc.to_json
        rescue Exception => e
          return_doc['success'] = false
          return_doc['message'] = e.message
          render json: return_doc.to_json
        end
      end
    end   
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created.' 
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated.' 
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      flash[:success] = 'User was successfully deleted.' 
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if (params[:user][:email]).present?
        @user = User.find_by(email: params[:user][:email])
        @user = User.new(email: params[:user][:email]) unless @user
      elsif params[:id].present?
        @user = User.find(params[:id])
        @user = User.new unless @user
      end
      if @user && @user.persisted?
        @address = @user.user_addresses.count > 0 ? @user.user_addresses.first : UserAddress.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(
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

    def user_params
      params.require(:user).permit(
        :email,
        :prefix,
        :first_name,
        :middle_name,
        :last_name,
        :suffix,
        :title,
        :locale,
        :new_password,
        :new_password_confirmation,
        :marketing)
    end
end
