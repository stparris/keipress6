class PaymentGateway < ApplicationRecord
	belongs_to :site
	has_many :payment_types

	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: " is already in use for this site" }

	attr_accessor :gateway, :ip_address, :credit_card, :currency, :amount

 	def self.gateway_types
 		{
 			'PayPal'=>'paypal',
 			'Test Only'=>'test_only'
 		}
 	end

 	def brands
		case self.gateway_type
		when 'paypal'
			{'Visa'=>'visa', 'Mastercard'=>'master', 'American Express'=>'american_express', 'Discover'=>'discover'}
		when 'square'
			{'Visa'=>'visa', 'Mastercard'=>'master', 'American Express'=>'american_express', 'Discover'=>'discover','JCB'=>'jcb'}
		else
			{'Bogus'=>'bogus'}
		end	
 	end

	def gateway_mode
		ActiveMerchant::Billing::Base.mode = self.mode.to_sym
	end

	def gateway_config
		case self.gateway_type
		when 'paypal'
			ActiveMerchant::Billing::PaypalGateway.new(
	  		login: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:paypal,:login),
	  		password: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:paypal,:password),
	  		signature: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:paypal,:signature)
			)
		when 'square'
			ActiveMerchant::Billing::SquareGateway.new(
	  		login: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:square,:login),
	  		password: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:square,:password),
	  		location_id: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:square,:location_id)
			)
		when 'trust_commerce'
			ActiveMerchant::Billing::TrustCommerceGateway.new(
	  		login: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:trust_commerce,:login),
	  		password: Rails.application.credentials.dig(:sites,self.site.sym_name,:gateways,:trust_commerce,:password)
			)
		else
			# Test only gateway
			ActiveMerchant::Billing::TrustCommerceGateway.new(
        :login => 'TestMerchant',
        :password => 'password'
      )
		end
	end

	def purchase
		if self.credit_card.validate
			self.gateway_mode
			gateway = self.gateway_config
			response_obj = {}
			response_obj['error'] = nil
			response_obj['errors'] = {}
			purchase_amount = (self.amount * 100).to_i
			options = {currency: self.currency}
			options[:ip] = self.ip_address if self.gateway_type == 'paypal'
			response = gateway.purchase(purchase_amount, credit_card, options)
     	response_obj['details'] = response.inspect
      if response.success?
      	# capture = gateway.capture(purchase_amount, response.authorization)
        # response_obj['details'] = capture.inspect
        response_obj['authorization'] = response.authorization
        response_obj['message'] = response.message
      else
        response_obj['error'] = response.error_code
        response_obj['message'] = response.message
        response_obj['errors']['brand'] = 1 if response.message =~ /valid credit card/
        response_obj['errors']['card_number'] = 1 if response.message =~ /valid credit card/
        response_obj['errors']['expiration'] = 1 if response.message =~ /valid credit card/
        response_obj['errors']['validation'] = 1 if response.message =~ /valid credit card/
      end
    else
      response_obj['error'] = 'invalid_card'
      response_obj['errors']['card_number'] = 1
      response_obj['message'] = credit_card.errors.full_messages.join(' ')
    end
    return response_obj
	end

end

__END__

{"error"=>:processing_error,
 "message"=>"This transaction cannot be processed. Please use a valid credit card.",
 "details"=>"#<ActiveMerchant::Billing::Response:0x00007fde8faa1f70 @params={"timestamp"=>"2019-10-17T00:08:41Z",
 "ack"=>"Failure",
 "correlation_id"=>"74539824a54c4",
 "version"=>"124",
 "build"=>"53714519",
 "amount"=>"1104.00",
 "amount_currency_id"=>"EUR",
 "message"=>"This transaction cannot be processed. Please use a valid credit card.",
 "error_codes"=>"10502",
 "Timestamp"=>"2019-10-17T00:08:41Z",
 "Ack"=>"Failure",
 "CorrelationID"=>"74539824a54c4",
 "Errors"=>{"ShortMessage"=>"Invalid Data",
 "LongMessage"=>"This transaction cannot be processed. Please use a valid credit card.",
 "ErrorCode"=>"10502",
 "SeverityCode"=>"Error"},
 "Version"=>"124",
 "Build"=>"53714519",
 "Amount"=>"1104.00"},
 @message="This transaction cannot be processed. Please use a valid credit card.",
 @success=false,
 @test=true,
 @authorization=nil,
 @fraud_review=false,
 @error_code=:processing_error,
 @emv_authorization=nil,
 @avs_result={"code"=>nil,
 "message"=>nil,
 "street_match"=>nil,
 "postal_match"=>nil},
 @cvv_result={"code"=>nil,
 "message"=>nil}>"}
  Rendering rental_bookings/error.js.erb
  Rendered rental_bookings/error.js.erb (3.0ms)



