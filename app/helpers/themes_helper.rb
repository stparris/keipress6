module ThemesHelper

	def navigation_items(navigation)
		navigation.navigation_items.each do |item|
			item.css_classes.split(/\s/).each do |css|
				@theme_classes[css] = css
			end		
		end
	end

	def row_columns(row)
		row.row_columns.each do |col|
			col.css_classes.split(/\s/).each do |css|
				@theme_classes[css] = css
			end
		end
	end

	def container_rows(container)
		container.container_rows.each do |row|
			row_columns(row)
			row.css_classes.split(/\s/).each do |css|
				@theme_classes[css] = css
			end
		end
	end

	def page_containers(page)
		page.containers.each do |container|
			if container.container_type == 'navigation'
				navigation_items(container.navigation)
				container.navigation.css_classes.split(/\s/).each do |css|
					@theme_classes[css] = css
				end
			else
				container_rows(container)
			end
			container.css_classes.split(/\s/).each do |css|
				@theme_classes[css] = css
			end
		end
	end

	def theme_pages(theme)
		theme.pages.each do |page|
			page_containers(page)
		end
	end

	def theme_classes(theme)
		@theme_classes = {}
		theme_out = ".#{theme.css_class} {"
		theme_pages(theme)
		Hash[@theme_classes.sort].each_key do |css|
			theme_out += "\n\t.#{css} { }"
		end
		theme_out += "\n}"
		return theme_out
	end


end
