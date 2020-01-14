module MailTemplatesHelper

	def rental_booking_macros
		booking_macros
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
			'base_guests'=>'min_guests',
			'base_rate'=>'base_rate',
			'base_total'=>'base_total',
			'extra_rate'=>'extra_rate',
			'extra_guests'=>'extra_guests',
			'extra_total'=>'extra_total',
			'amount'=>'amount',
			'tax'=>'tax',
			'total_amount'=>'total_amount',
			'guest_comments'=>'details'
		}
	end

	def rental_booking_macros
		booking_macros
	end

	def tour_booking_macros
		booking_macros
	end	

	def event_booking_macros
		booking_macros
	end	

	def user_macros
		{
			'first_name'=>'first_name',
			'last_name'=>'last_name',
			'full_name'=>'full_name',
			'email'=>'email'
		}
	end

	def contact_macros
		{
			'first_name'=>'first_name',
			'last_name'=>'last_name',
			'details'=>'details',
			'email'=>'email'
		}
	end

	def rental_macros
		{
			'rental_name'=>'name',
			'currency'=>'currency',
			'min_days'=>'min_days',
			'min_guests'=>'min_guests',
			'max_guests'=>'max_guests',
      'tax_rate'=>'tax_rate',
      'deposit_percent'=>'deposit_percent'
		}
	end

	def misc_macros
		[
			'year',
			'today',
			'today-us'
		]
	end

	def process_mail_macros(template, objects = [])
		objects.each do |obj|
			obj.send("#{obj.class.name.split(/(?=[A-Z])/).map(&:downcase).join('_')}_macros").each do |macro, name|
				template = template.gsub(/{{#{macro}}}/, obj.send(name).to_s)
			end
		end
		misc_macros.each do |macro|
			Date.today.year if macro == 'year'
			Date.today.strftime("%-d %b %Y") if macro == 'today'
			Date.today.strftime("%B %-d, %Y") if macro == 'today-us'
		end
		return template
	end

end
