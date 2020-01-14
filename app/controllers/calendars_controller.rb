class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show,:update]
 
  require 'open-uri'
  require 'net/http' 

  def show                   
    response_obj = @calendar.check_availability(params[:start_date],params[:end_date])
    respond_to do |format|
      format.json { render json: response_obj.to_json }
    end
  end

  def update
    return_doc = {}
    return_doc['success'] = 'true'
    respond_to do |format|
      begin
        uri = URI(@calendar.import_url)
        @calendar.icalendar = Net::HTTP.get(uri)
        @calendar.icalendar = @calendar.icalendar.sub(/X-WR-CALNAME:.*$/,"X-WR-CALNAME:#{@site.name}-#{@calendar.name}")
        @calendar.save
        @calendar.merge(Booking.where("site_id = ? and end_date > ?", @site.id, Date.today.strftime("%Y-%m-%d")))
        booked = ""
        days = @calendar.parse
        days.each_key do |day| 
          days[day]['events'].each do |event|
            if event['summary'] =~ /\S+/
              booked += "'#{day}'," if event['summary'] =~ /\S+/
              break
            end
          end
        end
        return_doc['booked'] = booked.chop
        format.json { render json: return_doc.to_json }
      rescue Exception => e
        return_doc['success'] = 'false'
        return_doc['message'] = e.message
        render json: return_doc.to_json
      end  
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
      @site = @calendar.site
    end

end
