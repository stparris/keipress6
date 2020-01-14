class Admin::BookingTransactionsController < ApplicationController
  before_action :set_booking_transaction, only: [:show, :edit, :update, :destroy]

  # GET /booking_transactions
  # GET /booking_transactions.json
  def index
    @booking_transactions = BookingTransaction.all
  end

  # GET /booking_transactions/1
  # GET /booking_transactions/1.json
  def show
  end

  # GET /booking_transactions/new
  def new
    @booking_transaction = BookingTransaction.new
  end

  # GET /booking_transactions/1/edit
  def edit
  end

  # POST /booking_transactions
  # POST /booking_transactions.json
  def create
    @booking_transaction = BookingTransaction.new(booking_transaction_params)

    respond_to do |format|
      if @booking_transaction.save
        format.html { redirect_to admin_booking_transaction_url(@booking_transaction), notice: 'Booking transaction was successfully created.' }
        format.json { render :show, status: :created, location: @booking_transaction }
      else
        format.html { render :new }
        format.json { render json: @booking_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /booking_transactions/1
  # PATCH/PUT /booking_transactions/1.json
  def update
    respond_to do |format|
      if @booking_transaction.update(booking_transaction_params)
        format.html { redirect_to admin_booking_transaction_url(@booking_transaction), notice: 'Booking transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking_transaction }
      else
        format.html { render :edit }
        format.json { render json: @booking_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /booking_transactions/1
  # DELETE /booking_transactions/1.json
  def destroy
    @booking_transaction.destroy
    respond_to do |format|
      format.html { redirect_to booking_transactions_url, notice: 'Booking transaction was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking_transaction
      @booking_transaction = BookingTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_transaction_params
      
params.require(:booking_transaction).permit(:booking_id,:amount,:details)
    end
end
