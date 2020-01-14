module ContainerItemsHelper

	def truncate_with_tags(body = "&nbsp;")
		Truncato.truncate body, max_length: 200
	end

end
