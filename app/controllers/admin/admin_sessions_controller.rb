class Admin::AdminSessionsController < AdminController

	layout 'admins'

	def new

	end

	def create
    admin_session = AdminSession.new(admin_session_params)
    @admin = admin_session.authenticate

logger.info "=============================\n#{@admin.inspect}"

    if @admin
      flash[:success] = "Welcome #{@admin.full_name}"
      new_token = rand(@admin.id.to_i + 100000000)
      session[:admin_token] = new_token
      @admin.admin_token = new_token
      @admin.save!
      if @admin.role == 1 || @admin.sites.count > 1
        redirect_to admin_sites_path
      elsif @admin.sites.count == 1 
        redirect_to admin_site_path(@admin.sites.first)
      else
        flash[:danger] = "Sorry, there are no sites associated with this login."
        respond_to do |format|
          format.html { render action: 'new' }
        end
      end
    else
      flash[:danger] = "Invalid user/password combination"
			respond_to do |format|
	      format.html { render action: 'new' }
	    end
    end
	end

	def destroy
    @admin = nil
    session[:admin_token] = nil
    flash[:success] = "Logged out"
    redirect_to(:action => "new")
  end

  private

    def admin_session_params
      params.require(:admin_session).permit(:email,:password)
    end

end
