class Admin::RentalPaymentMethodsController < AdminController
  before_action :set_rental_payment_method, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  def sort
    params[:rental_payment_method].each_with_index do |id, index|
      item = RentalPaymentMethod.find(id)
      item.update_attribute(:position, index + 1) if item
    end
    render body: nil
  end

  # POST /rental_payment_methods
  # POST /rental_payment_methods.json
  def create
    @rental_payment_method = RentalPaymentMethod.new(rental_payment_method_params)
    @rental = @rental_payment_method.rental
    respond_to do |format|
      begin
        @rental_payment_method.save
        format.js
      rescue Exception => e
        logger.info "#{e.message}"
      end
    end
  end

  # DELETE /rental_payment_methods/1
  # DELETE /rental_payment_methods/1.json
  def destroy
    @rental = @rental_payment_method.rental
    @rental_payment_method.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental_payment_method
      @rental_payment_method = RentalPaymentMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_payment_method_params
      params.require(:rental_payment_method).permit(:payment_method_id,:rental_id,:position)
    end
end
