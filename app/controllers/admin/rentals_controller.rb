class Admin::RentalsController < AdminController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /rentals
  # GET /rentals.json
  def index
    @rentals = Rental.where(site_id: @site.id)
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
  end

  # GET /rentals/new
  def new
    @rental = Rental.new
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals
  # POST /rentals.json
  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.save
        flash[:success] = 'Rental was successfully created.'
        format.html { redirect_to admin_rental_url(@rental) }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1
  # PATCH/PUT /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        flash[:success] = 'Rental was successfully updated.'
        format.html { redirect_to admin_rental_url(@rental) }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      flash[:success] = 'Rental was successfully deleted.'
      format.html { redirect_to admin_rentals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @rental
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(
        :name,
        :site_id,
        :calendar_id,
        :min_days,
        :min_guests,
        :max_guests,
        :currency,
        :regular_dates,
        :discount_dates,
        :regular_rate,
        :discount_rate,
        :extras_rate,
        :extras_discount_rate,
        :tax_rate,
        :deposit_percent,
        :description)
    end
end
