require 'icalendar'

class Calendar < ApplicationRecord

	belongs_to :site
	has_many :rentals

	validates :name, presence: true, uniqueness: true
	before_save :check_parent
	before_save :set_export_url

	START_TIME = "T110000Z"
	END_TIME = "T110000Z"

	def booked(uuid = nil) 
		booked = ""
		days = self.parse
		days.each_key do |day| 
			days[day]['events'].each do |event|
				next if uuid && uuid == event['uid']
				if event['summary'] =~ /\S+/
					booked += "'#{day}'," if event['summary'] =~ /\S+/
					break
				end
			end
		end
		return booked.chop
	end


	def check_parent
		if self.parent == true
			Calendar.where('parent = true and site_id = ? and id != ?', self.site_id, self.id).update_all(parent: false)
		end
	end

	# Deletes event from icalendar
	def delete_event(uuid)
		event = {}
		new_calendar = ""
		got_event = false
		got_key = false
		stale_event = false
		self.icalendar.split(/\n/).each do |line|
			if line =~ /BEGIN:VEVENT/
				got_event = true 
				next
			end
			got_key = true if line =~ /#{uuid}/
			if got_event
			 	key_val = line.split(/:/)
			 	event[key_val[0]] = key_val[1]
				if line =~ /END:VEVENT/
					unless got_key
						new_calendar += "BEGIN:VEVENT\n" 
						event.each do |key,value|
							new_calendar += "#{key}:#{value}\n"
						end
					end
					event = {}
					got_key = false		
					got_event = false 
				end
			else 
				new_calendar += "#{line}\n"
			end
		end
		self.icalendar = new_calendar 
		self.save
	end

	# Sets status = CANCELLED in icalendar
	def cancel_event(uuid)
		update_cal = ""
		self.icalendar.split(/\n/).each do |line|
			if line =~ /#{uuid}/
				update_cal += "#{line}\nSTATUS:CANCELLED\n"
			else 
				update_cal += "#{line}\n"
			end
		end
		self.icalendar = update_cal
		self.save
	end

	def merge(bookings)
		update_bookings = []
		new_bookings = []
		bookings.each do |booking|
			if self.icalendar =~ /#{booking.uuid}/m
				update_event(booking)
			else
				new_bookings << booking
			end
		end
		new_bookings.each do |booking|
			event = Icalendar::Event.new
			event.uid = booking.uuid
			event.created = Time.now.getutc.strftime("%Y%m%dT%H%M%SZ")
			event.dtstamp = Time.now.getutc.strftime("%Y%m%dT%H%M%SZ")
			event.dtstart = booking.start_date.strftime("%Y%m%d")+START_TIME
			event.dtend = booking.end_date.strftime("%Y%m%d")+END_TIME
			event.description = "#{booking.guests} guests"
			event.summary = "Booking for #{booking.user.full_name}"
			self.create_event(event)
		end

	end

	def update_event(booking)
		event = {}
		new_calendar = ""
		got_event = false
		got_key = false
		stale_event = false
		self.icalendar.split(/\n/).each do |line|
			if line =~ /BEGIN:VEVENT/
				got_event = true 
				next
			end
			got_key = true if line =~ /#{booking.uuid}/
			if got_event
			 	key_val = line.split(/:/)
			 	event[key_val[0]] = key_val[1]
				if line =~ /END:VEVENT/
					new_calendar += "BEGIN:VEVENT\n" 
					if event['DTSTAMP'] && booking.updated_at > Date.parse(event['DTSTAMP'])
						stale_event = true 
					end
					event.each do |key,value|
						if key ==  'DESCRIPTION' && got_key && stale_event
							new_calendar += "#{key}:#{booking.guests} guests\n"
						elsif key == 'DTEND' && got_key && stale_event
							new_calendar += key+":"+booking.end_date.strftime("%Y%m%d")+"#{END_TIME}\n"
						elsif key == 'DTSTART' && got_key && stale_event
							new_calendar += key+":"+booking.start_date.strftime("%Y%m%d")+"#{START_TIME}\n"
						elsif key == 'SUMMARY' && got_key && stale_event
							new_calendar += "#{key}:Booking for #{booking.user.full_name} with updates\n"
						elsif key == 'DTSTAMP' && got_key && stale_event
							new_calendar += key+":"+Time.now.getutc.strftime("%Y%m%dT%H%M%SZ")+"\n"
						else
							new_calendar += "#{key}:#{value}\n"
						end
					end
					event = {}
					got_key = false		
					got_event = false 
					stale_event = false
				end
			else 
				new_calendar += "#{line}\n"
			end
		end
		self.icalendar = new_calendar 
		self.save
	end

	def create_event(event)
		cals = Icalendar::Calendar.parse(self.icalendar)
		cal = cals.first
		cal.add_event(event)
		self.icalendar = cal.to_ical
		self.save		
	end

	def set_export_url
		self.export_url = "https://#{self.site.domains.first.name}/calendars/#{self.id}/export"
	end

	def self.parse_calendars_for_site(site)
		days = {}
		site.calendars.each do |cal|
			days = cal.parse(days)
		end
		return days
	end

	def parse(days = {})
		cals = Icalendar::Calendar.parse(self.icalendar)
		cal = cals.first
		cal.events.each do |e|
			next if e.status == 'CANCELLED'
		# Begin date
			date_str = e.dtstart.strftime("%Y-%m-%d")
			days[date_str] ||= {}
			days[date_str]['events'] ||= []
			days[date_str]['wday'] = e.dtstart.strftime("%w")
			event = {}
			event['summary'] = e.summary
			event['name'] = self.name
			event['uid'] = e.uid
			days[date_str]['events'] << event
		# End date
			date_str = e.dtend.strftime("%Y-%m-%d")
			days[date_str] ||= {}
			days[date_str]['events'] ||= []
			days[date_str]['wday'] = e.dtend.strftime("%w")
			event = {}
			event['summary'] = e.summary
			event['name'] = self.name
			event['uid'] = e.uid
			days[date_str]['events'] << event
		# Loop to end date	
			next_date = e.dtstart + 1.day
			until next_date >= e.dtend do
				date_str = next_date.strftime("%Y-%m-%d")
				days[date_str] ||= {}
				days[date_str]['wday'] = next_date.strftime("%w")
				days[date_str]['events'] ||= []
				event = {}
				event['summary'] = e.summary
				event['name'] = self.name
				event['uid'] = e.uid
				days[date_str]['events'] << event
				next_date = next_date + 1.day
			end
		end
		sorted = days.sort_by { |date_str| date_str }
		last_date = sorted.last[0]
		date = 1.week.ago
		date_str = date.strftime("%Y-%m-%d")
		until date_str == last_date do 
			unless days[date_str]
				days[date_str] = {}
				days[date_str]['events'] = []
				days[date_str]['wday'] = date.strftime("%w")
				event = {}
				event['summary'] = ""
				event['name'] = ""
				event['uid'] = ""
				days[date_str]['events'] << event
			end
			date = date + 1.day
			date_str = date.strftime("%Y-%m-%d")
		end
		sorted = days.sort_by { |date_str| date_str }.to_h
		return sorted
	end

	def check_availability(start_str,end_str,uuid = "no-match-#{rand(6)}")
		start_date = start_str.to_date
		end_date = end_str.to_date
		if start_date > end_date
			return {'Start date must be before end date' => false, 'conflict' => true}
		else
			dates = {}
			dates['conflict'] = false 
			dates['booked'] = []
			dates['debug'] = ""
			# dates['debug'] = ""
			days = self.parse
			next_date = start_date
			until next_date == end_date do
				date_str = next_date.strftime("%Y-%m-%d")
				dates[date_str] = true
				if days[date_str]
					days[date_str]['events'].each do |event|
						dates[date_str] = false if event['summary'] =~ /\S+/ && event['uid'] != uuid
						dates['debug'] += "#{date_str} #{event['summary']}\n"
					end
					if dates[date_str] == false
						dates['conflict'] = true 
						dates['booked'] << Date.parse(date_str).strftime("%-d %b %Y")
					end
				end
				next_date = next_date + 1.day
			end
			sorted = dates.sort_by { |date_str| date_str }.to_h
			return sorted
		end
	end
end
