class ErrorsController < ProductionController 
	before_action :set_error
	
	layout 'application'


	def index
	end

	def new
	end

	def show
	end

	private
		def set_error
			@error = Error.new(template:  params[:template])
		end
end