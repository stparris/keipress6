class Error
	include ActiveModel::Model

	attr_accessor :error_template	
	attr_accessor :message

end