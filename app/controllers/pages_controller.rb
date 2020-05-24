class PagesController < ProductionController
  before_action :set_page

  layout 'application'

  def show

  end

  def static_asset

  end

  def letsencrypt
    # use your code here, not mine
    render text: params[:id]
  end

  private

    def set_page
      if params[:nice_url].present?
        @page = Page.find_by(nice_url: params[:nice_url], site_id: @site.id)
        if @page && @page.assignment =~ /booking-\S{2}-rental/
          rental = Rental.find(@page.assignment.split(/:/)[1])
          if rental
            @rental_booking = RentalBooking.new()
            @rental_booking.rental = rental
          else
            @page = nil
          end
        end
        @page = Page.find_by(site_id: @site.id, assignment: 'home') unless @page
        @muparams = params[:muparams].present? ? params[:muparams] : nil
      end
      unless @page
        @page = Page.find_by(site_id: @site.id, assignment: 'home')
      end
    end
end

