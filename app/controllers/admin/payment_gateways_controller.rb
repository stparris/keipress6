class Admin::PaymentGatewaysController < AdminController
  before_action :set_payment_gateway, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /payment_gateways
  # GET /payment_gateways.json
  def index
    @payment_gateways = PaymentGateway.all
  end

  # GET /payment_gateways/1
  # GET /payment_gateways/1.json
  def show
  end

  # GET /payment_gateways/new
  def new
    @payment_gateway = PaymentGateway.new(config: {gateway_name: 'gateway_name',login_key: 'login_key_name',password_key: 'password_key_name',signature_key: 'signature_key_name'}.to_json.sub(/\{/,"{\n\s\s").gsub(/\,/,",\n\s\s").sub(/\}/,"\n}"))
  end

  # GET /payment_gateways/1/edit
  def edit
  end

  # POST /payment_gateways
  # POST /payment_gateways.json
  def create
    @payment_gateway = PaymentGateway.new(payment_gateway_params)

    respond_to do |format|
      if @payment_gateway.save
        flash[:success] = 'Payment gateway was successfully created.'
        format.html { redirect_to admin_payment_gateway_url(@payment_gateway) }
        format.json { render :show, status: :created, location: @payment_gateway }
      else
        format.html { render :new }
        format.json { render json: @payment_gateway.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_gateways/1
  # PATCH/PUT /payment_gateways/1.json
  def update
    respond_to do |format|
      if @payment_gateway.update(payment_gateway_params)
        flash[:success] = 'Payment gateway was successfully updated.'
        format.html { redirect_to admin_payment_gateway_url(@payment_gateway) }
        format.json { render :show, status: :ok, location: @payment_gateway }
      else
        format.html { render :edit }
        format.json { render json: @payment_gateway.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_gateways/1
  # DELETE /payment_gateways/1.json
  def destroy
    @payment_gateway.destroy
    respond_to do |format|
      flash[:success] = 'Payment gateway was successfully deleted.'
      format.html { redirect_to payment_gateways_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_gateway
      @payment_gateway = PaymentGateway.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @payment_gateway
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_gateway_params
      params.require(:payment_gateway).permit(:name,:site_id,:mode,:gateway_type,:config)
    end
end
