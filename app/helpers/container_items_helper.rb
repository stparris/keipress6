module ContainerItemsHelper

	def truncate_with_tags(body)
		Truncato.truncate body, max_length: 200 if body
	end

end
