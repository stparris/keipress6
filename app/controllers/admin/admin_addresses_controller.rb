class Admin::AdminAddressesController < AdminController
  before_action :set_admin_address, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /Adminaddress/1
  # GET /Adminaddress/1.json
  def show
  end

  # GET /Adminaddress/new
  def new
    @admin_address = AdminAddress.new
  end

  # GET /Adminaddress/1/edit
  def edit
  end

  # POST /Adminaddress
  # POST /Adminaddress.json
  def create
    @admin_address = AdminAddress.new(AdminAddress_params)

    respond_to do |format|
      if @admin_address.save
        flash[:success] = 'Admin address was successfully created.'
        format.html { redirect_to admin_admin_address_url(@admin_address) }
        format.json { render :show, status: :created, location: @admin_address }
      else
        format.html { render :new }
        format.json { render json: @admin_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Adminaddress/1
  # PATCH/PUT /Adminaddress/1.json
  def update
    respond_to do |format|
      if @admin_address.update(AdminAddress_params)
        flash[:success] = 'Admin address was successfully updated.'
        format.html { redirect_to admin_admin_address_url(@admin_address) }
        format.json { render :show, status: :ok, location: @admin_address }
      else
        format.html { render :edit }
        format.json { render json: @admin_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Adminaddress/1
  # DELETE /Adminaddress/1.json
  def destroy
    @admin_address.destroy
    respond_to do |format|
      flash[:success] = 'Admin address was successfully deleted.'
      format.html { redirect_to admin_admin_addresses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_address
      @admin_address = AdminAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_address_params
      params.require(:admin_address).permit(
        :admin_id,
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
