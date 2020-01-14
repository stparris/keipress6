class Admin::DesignersController < AdminController

	layout 'admins'

	def index
    @design_type = params[:design_type] ? params[:design_type] : 'fonts'
	end

end