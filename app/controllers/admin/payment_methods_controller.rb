class Admin::PaymentMethodsController < AdminController
  before_action :set_payment_method, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /payment_methods
  # GET /payment_methods.json
  def index
    @payment_methods = PaymentMethod.where(site_id: @site.id)
  end

  # GET /payment_methods/1
  # GET /payment_methods/1.json
  def show
  end

  # GET /payment_methods/new
  def new
    @payment_method = PaymentMethod.new
  end

  # GET /payment_methods/1/edit
  def edit
  end

  # POST /payment_methods
  # POST /payment_methods.json
  def create
    @payment_method = PaymentMethod.new(payment_method_params)

    respond_to do |format|
      if @payment_method.save
        flash[:success] = 'Payment method was successfully created.'
        format.html { redirect_to admin_payment_method_url(@payment_method) }
        format.json { render :show, status: :created, location: @payment_method }
      else
        format.html { render :new }
        format.json { render json: @payment_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_methods/1
  # PATCH/PUT /payment_methods/1.json
  def update
    respond_to do |format|
      if @payment_method.update(payment_method_params)
        flash[:success] = 'Payment method was successfully updated.'
        format.html { redirect_to admin_payment_method_url(@payment_method) }
        format.json { render :show, status: :ok, location: @payment_method }
      else
        format.html { render :edit }
        format.json { render json: @payment_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_methods/1
  # DELETE /payment_methods/1.json
  def destroy
    @payment_method.destroy
    respond_to do |format|
      flash[:success] = 'Payment method was successfully deleted.'
      format.html { redirect_to admin_payment_methods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_method
      @payment_method = PaymentMethod.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @payment_method
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_method_params
      params.require(:payment_method).permit(
        :name,
        :locale,
        :site_id,
        :payment_type_id,
        :active,
        :instructions,
        :summary_page_html,
        :user_mail_template_id,
        :admin_mail_template_id)
    end
end
