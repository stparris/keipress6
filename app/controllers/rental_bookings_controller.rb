class RentalBookingsController < ProductionController
  before_action :set_rental_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create]

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @rental_booking = RentalBooking.new(rental_booking_params)
    respond_to do |format|
      format.json do
        begin
          response_obj = @rental_booking.get_details
          response_obj['success'] = 'true'
          render json: response_obj.to_json
        rescue Exception => e
          response_obj = {}
          response_obj['success'] = 'false'
          response_obj['message'] = e.message
          mail_server = MailServer.find_by(site_id: @site.id, active: true)
          mail_template = MailTemplate.find_by(site_id: @site.id, recipient_type: 'admin', template_type: 'error')
          mail_template = @site.gen_error_mail_template unless mail_template
          from_mail = mail_template.from_mail
          subject = mail_template.subject
          html = mail_template.body_html.gsub(/\{\{details\}\}/, e.message)
          text = mail_template.body_text.gsub(/\{\{details\}\}/, e.message)
          AdminErrorJob.perform_later(mail_server,from_mail,subject,html,text)            
          render json: response_obj.to_json
        end
      end
    end
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    respond_to do |format|
      begin
        card_display_number = nil
        @rental_booking = RentalBooking.new(rental_booking_params)
        if @user.persisted?
          @user.update!(user_params)
        else
          @user = User.new(user_params)
          pw = rand.to_s
          @user.new_password = pw
          @user.new_password_confirmation = pw
          @user.save!
        end
        @rental_booking.user = @user
        @booking_transaction = BookingTransaction.new()
        if params[:user_address].present?
          if @user.primary_address
            @user.primary_address.update!(user_address_params)
          else
            user_address = UserAddress.new(user_user_address_params)
            user_address.user = @user
            user_address.save!
          end
          @booking_transaction.billing_address = user_address
        end
        if params[:user_billing_address].present?
          if @user.billing_address
            @user.billing_address.update!(user_billing_address_params)
          else
            billing_address = UserBillingAddress.new(user_billing_address_params)
            billing_address.user = @user
            billing_address.save!
          end
          @booking_transaction.billing_address = billing_address
        end
        if params[:user_card_addresses].present?
          if @user.card_address
            @user.card_address.update!(user_card_address_params)
          else
            card_address = UserCardAddress.new(user_card_address_params)
            card_address.user = @user
            card_address.save!
          end
          @booking_transaction.card_address = card_address
        end
        if params[:user_shipping_addresses].present?
          if @user.shipping_address
            @user.shipping_address.update!(user_shipping_address_params)
          else
            shipping_address = UserShippingAddress.new(user_shipping_address_params)
            shipping_address.user = @user
            shipping_address.save!
          end
        end
        @booking_transaction.payment_type = @rental_booking.payment_method.payment_type
        @booking_transaction.amount = @rental_booking.total_amount
        if @rental_booking.payment_method.payment_type.payment_type =~ /card/
          card = PaymentCard.new(payment_card_params)
          card_display_number = card.display_number
          payment_gateway = @rental_booking.payment_method.payment_type.payment_gateway
          payment_gateway.amount = @rental_booking.total_amount
          payment_gateway.ip_address = request.remote_ip
          payment_gateway.credit_card = card.config_card
          payment_gateway.currency = @rental_booking.rental.currency
          response = payment_gateway.purchase
          if response['error']
            @message = response['message']
            @errors = response['errors']
          else  
            @rental_booking.status = "confirmed_#{@rental_booking.payment_method.payment_type.payment_type}"   
            @rental_booking.save!
            @booking_transaction.booking = @rental_booking
            @booking_transaction.details = "#{response['message']} #{card.display_number}"
            @booking_transaction.save!
          end
        elsif @rental_booking.payment_method.payment_type.payment_type == 'check'
          @rental_booking.status = 'check'   
          @rental_booking.save!     
        elsif @rental_booking.payment_method.payment_type.payment_type == 'invoice'
          @rental_booking.status = 'invoice'   
          @rental_booking.save!       
        else
          @rental_booking.status = 'contact'   
          @rental_booking.save!
        end
        if @errors
          format.js { render 'error' }     
        else
          # include MailTemplatesHelper
          mail_server = MailServer.find_by(site_id: @site.id, active: true)

          mail_template = @rental_booking.payment_method.user_mail_template
          subject = @rental_booking.process_macros(mail_template.subject)
          html = @rental_booking.process_macros(mail_template.body_html)
          text = @rental_booking.process_macros(mail_template.body_text)
          html = html.gsub(/\{\{card_display\}\}/, card_display_number) if card_display_number
          text = text.gsub(/\{\{card_display\}\}/, card_display_number) if card_display_number
          UserContactJob.perform_later(mail_server,mail_template.from_email,@user.email,subject,html,text)
          
          mail_template = @rental_booking.payment_method.admin_mail_template
          subject =  @rental_booking.process_macros(mail_template.subject)
          html = @rental_booking.process_macros(mail_template.body_html)
          text = @rental_booking.process_macros(mail_template.body_text)
          html = html.gsub(/\{\{card_display\}\}/, card_display_number) if card_display_number
          text = text.gsub(/\{\{card_display\}\}/, card_display_number) if card_display_number
          AdminContactJob.perform_later(mail_server,mail_template.from_email,subject,html,text)
          I18n.locale = @user.locale.to_sym
          format.js { render :show }
        end
      rescue Exception, RentalBooking::RentalBookingConflict => e 
        @booking_error = "Problem with booking "
        error_text = "Problem with booking\n"
        if e.message.is_a?(Hash)
          @booking_error += "<ul class=\"error-list\"><li><strong>Date conflict</strong></li>"
          e.message.each do |key,value|
            next if key == 'conflict'
            @booking_error += "<li><i class=\"icon #{value == true ? 'icon-ok' : 'icon-cancel'}\"></i> #{key} #{'conflict' if value == false}</li>" 
            error_text += "#{key} #{'conflict' if value == false}\n"
          end
          @booking_error += "</ul>"
        else
          @booking_error += "<p>#{e.message}</p>"
          error_text += e.message
        end
        mail_server = MailServer.find_by(site_id: @site.id, active: true)
        mail_template = MailTemplate.find_by(site_id: @site.id, recipient_type: 'admin', template_type: 'error')
        mail_template = @site.gen_error_mail_template unless mail_template
        from_mail = mail_template.from_email
        subject = mail_template.subject
        html = mail_template.body_html.gsub(/\{\{details\}\}/, @booking_error)
        text = mail_template.body_text.gsub(/\{\{details\}\}/, error_text)
        AdminErrorJob.perform_later(mail_server,from_mail,subject,html,text)          
        format.js { render :error }
      end    
    end #end respond_to
  end 

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    # respond_to do |format|
    #   if @rental_booking.update(rental_booking_params)
    #     format.html { redirect_to @rental_booking, notice: 'RentalBooking was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @rental_booking }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @rental_booking.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    # @rental_booking.destroy
    # respond_to do |format|
    #   format.html { redirect_to bookings_url, notice: 'Rental booking was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new 
      @rental_booking = RentalBooking.new(site_id: @site.id)
    end

    def set_rental_booking
      @rental_booking = RentalBooking.find(params[:id])
      @user = @rental_booking.user
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
      else
        @user = User.new
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
        :state_id,
        :country_id)
    end

    def user_card_address_card_params
      params.require(:user_address).permit(
        :address1,
        :address2,
        :city,
        :post_code,
        :phone,
        :alternative_phone,
        :state_id,
        :country_id)
    end

    def user_billing_address_params
      params.require(:user_billing_address).permit(
        :address1,
        :address2,
        :city,
        :post_code,
        :phone,
        :alternative_phone,
        :state_id,
        :country_id)
    end    

    def user_shipping_address_params
      params.require(:user_shipping_address).permit(
        :address1,
        :address2,
        :city,
        :post_code,
        :phone,
        :alternative_phone,
        :state_id,
        :country_id)
    end

    def payment_card_params
      params.require(:payment_card).permit(
        :first_name, 
        :last_name, 
        :brand, 
        :card_number, 
        :expiration_month, 
        :expiration_year, 
        :card_verification, 
        :ip_address)
    end

    def rental_booking_params
      params.require(:rental_booking).permit(
        :name,
        :site_id,
        :user_id,
        :event_id,
        :tour_id,
        :rental_id,
        :start_date,
        :end_date,
        :details,
        :guests,
        :payment_method_id,
        :check_email,
        :check_availability)
    end
end
