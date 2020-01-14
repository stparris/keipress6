require 'securerandom'

class Booking < ApplicationRecord
	belongs_to :site
	belongs_to :event, optional: true
	belongs_to :rental, optional: true
	belongs_to :tour, optional: true
	belongs_to :user
	belongs_to :payment_method

	validates :rental_id, presence: true
	validates :end_date, presence: true
	validates :guests, presence: true
	validates :start_date, presence: true
	validate :check_dates

	before_create :set_name
	before_create :set_uuid
	after_create :set_booking_number
	before_destroy :delete_event
	# BEST TO NOT AUTOMATE THESE? DEPENDING ON BOOKING STATUS
	# after_create :create_event
	# after_update :update_event

	attr_accessor :check_email, :check_availability, :date_range, :confirmed  

	def self.statuses
		{
			'Confirmed card full'=>'confirmed_card_paid',
			'Confirmed other full'=>'confirmed_other_paid',
			'Confirmed card deposit'=>'confirmed_card_deposit',
			'Confirmed other deposit'=>'confirmed_other_deposit',
			'Confirmed email'=>'confirmed_email',
			'Email confirmation pending'=>'email_pending',
			'Deposit pending'=>'deposit_pending',
			'Inquirey'=>'Inquirey',
			'Cancelled'=>'cancelled'
		}
	end

	START_TIME = "T110000Z"
	END_TIME = "T110000Z"

	def set_name
		self.name = "#{self.rental.name} Booking for #{self.user.full_name}"
	end

	def set_booking_number
		type = "R#{self.rental.id}" if self.rental
		type = "E#{self.event.id}" if self.event
		type = "T#{self.tour.id}" if self.tour
		self.booking_number = "#{type}#{self.id}#{rand(3)}"
		self.save
	end

	def set_uuid
		self.uuid = SecureRandom.uuid 
	end

	def update_event
		if self.rental.calendar.parent == true
			self.site.calendars.each do |cal|
				cal.update_event(self)
			end
		else
			self.rental.calendar.update_event(self)
			parent = Calendar.find_by(parent: true)
			parent.update_event(self) if parent
		end
	end

	def delete_event
		if self.rental.calendar.parent == true
			self.site.calendars.each do |cal|
				cal.delete_event(self.uuid)
			end
		else
			self.rental.calendar.delete_event(self.uuid)
			parent = Calendar.find_by(parent: true)
			parent.delete_event(self.uuid) if parent
		end
	end

	def cancel_event
		if self.rental.calendar.parent == true
			self.site.calendars.each do |cal|
				cal.cancel_event(self.uuid)
			end
		else
			self.rental.calendar.cancel_event(self.uuid)
			parent = Calendar.find_by(parent: true)
			parent.cancel_event(self.uuid) if parent
		end
	end

	def create_event
		# Todo? use site time zone to convert dates (from ech)
    # eb_pacific = ActiveSupport::TimeZone[self.site.time_zone].parse("#{self.early_bird_date} 23:59:59")  
		# tz = TZInfo::Timezone.get self.site.time_zone
		# timezone = tz.ical_timezone event_start
		# cal.add_timezone timezone

		# DTSTART:20200214T110001Z
		# DTEND:20200224T110001Z
		event = Icalendar::Event.new
		event.uid = self.uuid
		event.created = Time.now.getutc.strftime("%Y%m%dT%H%M%SZ")
		event.dtstamp = Time.now.getutc.strftime("%Y%m%dT%H%M%SZ")
		event.dtstart = self.start_date.strftime("%Y%m%d")+START_TIME
		event.dtend = self.end_date.strftime("%Y%m%d")+END_TIME
		event.description = "#{self.guests} guests"
		event.summary = "Booking for #{self.user.full_name}"
		self.rental.calendar.create_event(event)
		if self.rental.calendar.parent == true
			self.site.calendars.each do |cal|
				cal.create_event(event) 
			end
		else 
			parent = Calendar.where(site_id: self.site_id,parent: true).first
			parent.create_event(event) if parent
		end
	end

	def check_dates
		if self.rental.calendar && self.start_date && self.end_date
			days = self.rental.calendar.check_availability(self.start_date,self.end_date,self.uuid)
			if days['conflict'] == true
	  		raise BookingConflict.new(days)
	  	end
	  end
	end

  class BookingConflict < StandardError
  	def initialize(message)
  		@message = message
  	end
  	def message
  		@message
  	end
  end

end
