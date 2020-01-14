class Admin::ErrorsController < ProductionController 
	before_action :set_error
	
	layout 'admins'


	def index
	end

	def new
	end

	def show
	end

	private
		def set_error
			@error = Error.new(error_template: params[:error_template])
			@error.message = params[:message] if params[:message].present?
		end
end