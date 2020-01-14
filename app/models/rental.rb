class Rental < ApplicationRecord
	belongs_to :site
	belongs_to :calendar
	has_many :bookings
	has_many :rental_payment_methods
	has_many :payment_methods, through: :rental_payment_methods
	has_many :rental_booking_instructions

	validates :name, presence: true, uniqueness: { :scope => :site_id }     
	validates :site_id, presence: true
	validates :calendar_id, presence: true
	validates :min_days, presence: true, numericality: { only_integer: true }
	validates :min_guests, presence: true, numericality: { only_integer: true }
	validates :max_guests, presence: true, numericality: { only_integer: true }
	validates :currency, presence: true
	validates :regular_rate, presence: true, numericality: { only_integer: true }
	validates :discount_rate, presence: true, numericality: { only_integer: true }
	validates :extras_rate, presence: true, numericality: { only_integer: true }
	validates :extras_discount_rate, presence: true, numericality: { only_integer: true }
	validates :tax_rate, presence: true, numericality: true
	validates :other_fees, numericality: { only_integer: true }
	validates :deposit_percent, numericality: true

	validates_each :regular_dates, :discount_dates do |record, attr, value|
		valid = true
		attr_str = attr.to_s.sub(/_/, ' ').capitalize
		value.split(/\s*,\s*/).each do |range|
			range_format = true
			if range !~ /\d{4}\/\d{2}\/\d{2}-\d{4}\/\d{2}\/\d{2}/
				record.errors.add :base, "#{attr_str} range format #{range} is invalid."
				range_valid = false
			end
			if range_format == true
				start_end = range.split(/-/)
				if Date.parse(start_end[1]) < Date.parse(start_end[0])
					record.errors.add :base, "#{attr_str} range #{range} is invalid: Start date must be before end date."
				end
			end
		end
  end

	def check_dates(start_date,end_date)
		book_start = start_date # Date.parse(start_date) 
		book_end =  end_date # Date.parse(end_date) 
		regular = false
		self.regular_dates.split(/,\s*/).each do |range|
			date_strs = range.split(/-/)
			reg_start = Date.parse(date_strs[0])
			reg_end = Date.parse(date_strs[1]) 
			regular = true if reg_start <= book_end && book_start <= reg_end
		end
		return regular
	end

	def get_base_rate(start_date,end_date)
		check_dates(start_date,end_date) ? self.regular_rate : self.discount_rate
	end

	def get_extras_rate(start_date,end_date)
		check_dates(start_date,end_date) ? self.extras_rate : self.extras_discount_rate
	end

	def self.currencies
		{'Austrailian Dollar'=>'AUD','Euro'=>'EUR','Indonesian Rupiah'=>'IDR','UK Pound'=>'GBP','US Dollar'=>'USD'}
	end

end
