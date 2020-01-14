class RentalBooking < Booking

	before_save :set_amounts

	def first_name
		self.user.first_name
	end

	def last_name
		self.user.last_name
	end

	def email
		self.user.email
	end

	def rental_name
		self.rental.name
	end

	def check_in
		self.start_date.strftime("%-d %b %Y")
	end

	def check_out
		self.end_date.strftime("%-d %b %Y")
	end

	def nights
		(self.end_date - self.start_date).to_i
	end

	def is_regular_rate
		self.rental.check_dates(self.start_date,self.end_date) 
	end

	def payment_type
		self.payment_method.payment_type.payment_type.capitalize
	end

	def currency
		Money.locale_backend = :i18n
		Money.new(0, self.rental.currency).format.gsub(/\.|0/,'')
	end

	def base_guests
		self.rental.min_guests
	end

	def base_rate
		is_regular_rate ? self.rental.regular_rate : self.rental.discount_rate
	end

	def base_total
		base_rate * nights
	end

	def extra_rate
		self.is_regular_rate ? self.rental.extras_rate : self.rental.extras_discount_rate
	end

	def extra_guests
		self.guests - self.rental.min_guests
	end

	def extra_total
		extra_rate * extra_guests * nights
	end

	def amount
		base_rate * nights + ((( self.guests - self.rental.min_guests) * self.extra_rate) * self.nights)
	end

	def tax_rate_percent
		self.rental.tax_rate * 100
	end

	def tax
		(self.rental.tax_rate > 0 ? self.amount.to_f * self.rental.tax_rate : 0)
	end

	def total_amount
		amount + tax
	end

	def deposit_percent
		self.rental.deposit_percent
	end

	def deposit_days
		self.rental.deposit_days
	end

	def deposit
		(total_amount * deposit_percent).to_i
	end

	def get_details
		response_obj = {}
    response_obj['nights'] = self.nights
    response_obj['is_regular_rate'] = self.is_regular_rate          
    response_obj['base_rate'] = self.base_rate
    response_obj['extra_rate'] = self.extra_rate
    response_obj['amount'] = self.amount
    response_obj['tax_rate'] = "#{self.tax_rate_percent}%"
    response_obj['tax'] = self.tax
    response_obj['total'] = self.total_amount
    response_obj['deposit_percent'] = self.deposit_percent * 100
    response_obj['deposit_days'] = self.deposit_days
    response_obj['deposit'] = self.deposit.to_i
    return response_obj
	end

	def booking_macros
		{
			'first_name'=>'first_name',
			'last_name'=>'last_name',
			'email'=>'email',			
			'booking_id'=>'id',
			'booking_number'=>'booking_number',
			'rental_name'=>'rental_name',
			'payment_type'=>'payment_type',
			'currency'=>'currency',
			'start_date'=>'start_date',
			'end_date'=>'end_date',
			'check_in'=>'check_in',
			'end_date'=>'end_date',
			'check_out'=>'check_out',
			'nights'=>'nights',
			'guests'=>'guests',
			'base_guests'=>'base_guests',
			'base_rate'=>'base_rate',
			'base_total'=>'base_total',
			'extra_rate'=>'extra_rate',
			'extra_guests'=>'extra_guests',
			'extra_total'=>'extra_total',
			'amount'=>'amount',
			'tax'=>'tax',
			'total_amount'=>'total_amount',
			'deposit'=>'deposit',
			'guest_comments'=>'details'
		}
	end

	def misc_macros
		[
			'year',
			'today',
			'today-us'
		]
	end	

	def process_macros(template)
		self.send("booking_macros").each do |macro, name|
			template = template.gsub(/\{\{#{macro}\}\}/, self.send(name).to_s)
		end
		misc_macros.each do |macro|
			template = template.gsub(/\{\{#{macro}\}\}/, Date.today.year.to_s) if macro == 'year'
			template = template.gsub(/\{\{#{macro}\}\}/, Date.today.strftime("%-d %b %Y")) if macro == 'today'
			template = template.gsub(/\{\{#{macro}\}\}/, Date.today.strftime("%B %-d, %Y")) if macro == 'today-us'
		end
		return template
	end

	def set_amounts
		self.booking_amount = amount
		self.booking_total = tax
		self.booking_total = total_amount
	end


end