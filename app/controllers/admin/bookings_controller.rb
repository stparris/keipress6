class Admin::BookingsController < AdminController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create]
  before_action :set_rental, only: [:new]

  require 'mail'
  include MailTemplatesHelper

  layout 'admins'

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.where(site_id: @site.id)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    respond_to do |format|
      if params[:booking].present? && params[:booking][:check_email].present? 
        flash[:danger] = "Email is required" if @user.email !~ /\S+/
        @booking = Booking.new(booking_params)
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      else  
      #  begin
          @booking = Booking.new(booking_params)
          if @user.persisted?
            @user.update(user_params)
          else
            @user = User.new(user_params)
            pw = rand.to_s
            @user.new_password = pw
            @user.new_password_confirmation = pw
            @user.save!
          end
          # if @booking.payment_method.payment_type.addresses.count > 0 
          #   if @booking.payment_method.payment_type.addresses.include?('billing')

          #   else

          #   end

          #   if @user.user_addresses.any?
          #     @user_address = @user.user_addresses.first
          #     @user_address.update(user_address_params)
          #   else
          #     @user_address = UserAddress.new(user_address_params)
          #     @user_address.name = 'Primary'
          #     @user_address.user = @user
          #     @user_address.save
          #   end
          # end
          @booking = Booking.new(booking_params)
          @booking.user_id = @user.id
          @booking.save!
          flash[:success] = 'Booking was successfully created.'
          format.html { redirect_to admin_booking_url(@booking) }
          format.json { render :show, status: :created, location: @booking }
        # rescue Exception, Booking::BookingConflict => e 
        #   error_message = "Problem with booking "
        #   if e.message.is_a?(Hash)
        #     error_message += "<ul class=\"error-list\"><li><strong>Date conflict</strong></li>"
        #     e.message.each do |key,value|
        #       next if key == 'conflict'
        #       error_message += "<li><i class=\"icon #{value == true ? 'icon-ok' : 'icon-cancel'}\"></i> #{key} #{'conflict' if value == false}</li>" 
        #     end
        #     error_message += "</ul>"
        #   end
        #   flash[:danger] = error_message
        #   format.html { render :new }
        # end    
      end
    end
  end 

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      begin
        @booking.update(booking_params)
        flash[:success] = 'Booking was successfully updated.'
        format.html { redirect_to admin_booking_url(@booking) }
        format.json { render :show, status: :ok, location: @booking }
      rescue Exception, Booking::BookingConflict => e 
        error_message = "Problem with booking "
        if e.message.is_a?(Hash)
          error_message += "<ul class=\"error-list\"><li><strong>Date conflict</strong></li>"
          e.message.each do |key,value|
            next if key == 'conflict'
            error_message += "<li><i class=\"icon #{value == true ? 'icon-ok' : 'icon-cancel'}\"></i> #{key} #{'conflict' if value == false}</li>" 
          end
          error_message += "</ul>"
        end
        flash[:danger] = error_message
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      flash[:success] = 'Booking was successfully deleted.'
      format.html { redirect_to admin_bookings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
      @user = @booking.user
    end

    def set_rental
      if params[:rental_id].present?
        @rental = Rental.find(params[:rental_id])
      end
    end

    def set_user
      if params[:user].present? && params[:user][:email].present? 
        @user = User.find_by_email(params[:user][:email]) 
        @user = @user ? @user : User.new(user_params)
        @user_address = @user.persisted? && @user.user_addresses.any? ? @user.user_addresses.first : UserAddress.new
      else
        @user = User.new
        @user_address =  UserAddress.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :site_id,
        :email,
        :prefix,
        :first_name,
        :middle_name,
        :last_name,
        :suffix,
        :locale,
        :new_password,
        :new_password_confirmation,
        :title,
        :phone,
        :address1,
        :address2,
        :city,
        :state,
        :post_code,
        :country,
        :marketing,
        :status)
    end
    
    def user_address_params
      params.require(:user_address).permit(
        :address1,
        :address2,
        :city,
        :post_code,
        :phone,
        :alternative_phone,
        :user_id,
        :state_id,
        :country_id)
    end

    def card_address_params
      params.require(:user_address).permit(
        :address1,
        :address2,
        :city,
        :post_code,
        :phone,
        :alternative_phone,
        :user_id,
        :state_id,
        :country_id,
        :use_primary_address)
    end

    def billing_address_params
      params.require(:user_address).permit(
        :address1,
        :address2,
        :city,
        :post_code,
        :phone,
        :alternative_phone,
        :user_id,
        :state_id,
        :country_id,
        :use_primary_address)
    end
    
    def booking_params
      params.require(:booking).permit(
        :name,
        :booking_number,
        :site,
        :user,
        :event,
        :tour,
        :rental,
        :payment_method,
        :uuid,
        :start_date,
        :end_date,
        :details,
        :status,
        :email_confirmed,
        :guests,
        :booking_amount,
        :booking_tax,
        :booking_total,
        :check_email, 
        :check_availability, 
        :date_range)
    end

end
