class Admin::ReservationsController < AdminController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  layout 'admins'

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.where(site_id: @site.id)
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    respond_to do |format|
      begin
        if @reservation.save
          flash[:success] = 'Reservation was successfully created.'
          format.html { redirect_to admin_reservation_url(@reservation) }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      begin
        if @reservation.update(reservation_params)
          flash[:success] = 'Reservation was successfully updated.'
          format.html { redirect_to admin_reservation_url(@reservation) }
          format.json { render :show, status: :ok, location: @reservation }
        else
          format.html { render :edit }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      rescue Exception => e 
        flash[:danger] = "Oops! Something went wrong: #{e.message}"
        format.html { render :new }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    respond_to do |format|
      begin
        if @reservation.destroy
          flash[:success] = 'Reservation was successfully removed.'
          format.html { redirect_to admin_reservations_url }
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
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:user_id,:start_at,:end_at,site_id,:product_id,:quantity)
    end
end


