class Admin::PaymentTypesController < AdminController
  before_action :set_payment_type, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /payment_types
  # GET /payment_types.json
  def index
    @payment_types = PaymentType.where(site_id: @site.id)
  end

  # GET /payment_types/1
  # GET /payment_types/1.json
  def show
  end

  # GET /payment_types/new
  def new
    @payment_type = PaymentType.new
  end

  # GET /payment_types/1/edit
  def edit
  end

  # POST /payment_types
  # POST /payment_types.json
  def create
    @payment_type = PaymentType.new(payment_type_params)

    respond_to do |format|
      if @payment_type.save
        flash[:success] = 'Payment type was successfully created.'
        format.html { redirect_to admin_payment_type_url(@payment_type) }
        format.json { render :show, status: :created, location: @payment_type }
      else
        format.html { render :new }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_types/1
  # PATCH/PUT /payment_types/1.json
  def update
    respond_to do |format|
      if @payment_type.update(payment_type_params)
        flash[:success] = 'Payment type was successfully updated.'
        format.html { redirect_to admin_payment_type_url(@payment_type) }
        format.json { render :show, status: :ok, location: @payment_type }
      else
        format.html { render :edit }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_types/1
  # DELETE /payment_types/1.json
  def destroy
    @payment_type.destroy
    respond_to do |format|
      flash[:success] = 'Payment type was successfully deleted.'
      format.html { redirect_to payment_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_type
      @payment_type = PaymentType.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @payment_type
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_type_params
      params.require(:payment_type).permit(
        :name,
        :site_id,
        :payment_type,
        :payment_gateway_id,
        :show_email,
        :require_email,
        :show_user_names,
        :require_user_names,
        :show_primary_address,
        :require_card_address,
        :require_billing_address,
        :require_shipping_address
      )
    end

end
