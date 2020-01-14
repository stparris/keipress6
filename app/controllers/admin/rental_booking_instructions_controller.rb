class Admin::RentalBookingInstructionsController < AdminController
  before_action :set_rental_booking_instruction, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]

  layout 'admins'

  # GET /rental_booking_instructions/1
  # GET /rental_booking_instructions/1.json
  def show
  end

  # GET /rental_booking_instructions/new
  def new
    
  end

  # GET /rental_booking_instructions/1/edit
  def edit
  end

  # POST /rental_booking_instructions
  # POST /rental_booking_instructions.json
  def create
    @rental_booking_instruction = RentalBookingInstruction.new(rental_booking_instruction_params)
    respond_to do |format|
      if @rental_booking_instruction.save
        flash[:success] = 'Rental booking instruction was successfully created.'
        format.html { redirect_to admin_rental_booking_instruction_url(@rental_booking_instruction) }
        format.json { render :show, status: :created, location: @rental_booking_instruction }
      else
        format.html { render :new }
        format.json { render json: @rental_booking_instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rental_booking_instructions/1
  # PATCH/PUT /rental_booking_instructions/1.json
  def update
    respond_to do |format|
      if @rental_booking_instruction.update(rental_booking_instruction_params)
        flash[:success] = 'Rental booking instruction was successfully updated.'
        format.html { redirect_to admin_rental_booking_instruction_url(@rental_booking_instruction) }
        format.json { render :show, status: :ok, location: @rental_booking_instruction }
      else
        format.html { render :edit }
        format.json { render json: @rental_booking_instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rental_booking_instructions/1
  # DELETE /rental_booking_instructions/1.json
  def destroy
    @rental = @rental_booking_instruction.rental
    @rental_booking_instruction.destroy
    respond_to do |format|
      flash[:success] = 'Rental booking instruction was successfully destroyed.'
      format.html { redirect_to admin_rental_url(@rental) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental_booking_instruction
      @rental_booking_instruction = RentalBookingInstruction.find(params[:id])
    end

    def set_new
      @rental = Rental.find(params[:rental_id])
      @rental_booking_instruction = RentalBookingInstruction.new
      @rental_booking_instruction.name = "#{@rental.name} LANG Booking Instructions"
      @rental_booking_instruction.rental = @rental
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_booking_instruction_params
      params.require(:rental_booking_instruction).permit(
        :name,
        :css_classes,
        :locale,
        :regular_rate_instructions,
        :discount_rate_instructions,
        :booking_instructions,
        :payment_instructions,
        :booking_button_text,
        :rental_id)
    end
end
