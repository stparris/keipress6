class Admin::CalendarsController < AdminController
  before_action :set_calendar, only: [:import, :export, :show, :edit, :update, :destroy]
  
  require 'open-uri'
  require 'net/http'

  layout 'admins'

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.where(site_id: @site.id)
  end

  def import
    respond_to do |format|
      format.js do
      # begin  
          uri = URI(@calendar.import_url)
          @calendar.icalendar = Net::HTTP.get(uri)
          @calendar.icalendar = @calendar.icalendar.sub(/X-WR-CALNAME:.*$/,"X-WR-CALNAME:#{@site.name}-#{@calendar.name}")
          @calendar.save
          @calendar.merge(Booking.where("site_id = ? and end_date > ?", 4, Date.today.strftime("%Y-%m-%d")))
       # rescue Exception => e
       #   @message = "An error occurred: #{e.message}"
       # end
      end
    end
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)
    respond_to do |format|
      if @calendar.save
        flash[:success] = 'Calendar was successfully created.'
        format.html { redirect_to admin_calendar_url(@calendar) }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        flash[:success] = 'Calendar was successfully updated.'
        format.html { redirect_to admin_calendar_url(@calendar) }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      flash[:success] = 'Calendar was successfully deleted.'
      format.html { redirect_to admin_calendars_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find_by(id: params[:id],site_id: @site.id)
      redirect_to admin_errors_url(error_template: '403') unless @calendar
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:name,:site_id,:import_url,:export_url,:icalendar,:parent)
    end
end
