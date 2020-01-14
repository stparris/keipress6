module PagesHelper

	def page_layout(page)
		layout = "<div class=\"page-layput\">"
		page.containers.order('position asc').each do |container|
			layout += "\n\t<div class=\"container-layout\">"
			layout += "\n\t\t<p>Container: #{container.name}</p>"
			layout += "\n\t\t<p>CSS: #{container.css_classes}</p>"
			if container.container_type == 'navigation'
				layout += "\n\t\t<div class=\"navigation-layout\">"
				layout += "\n\t\t\t<p>Navigation: #{container.navigation.name}</p>"
				layout += "\n\t\t\t<p>CSS: #{container.navigation.css_classes}</p>"
				container.navigation.navigation_items.order('position asc').each do |item|
					layout += "\n\t\t\t<div class=\"item-layout\">"
					layout += "\n\t\t\t\t<p>Item: #{item.name}</p>"
					layout += "\n\t\t\t\t<p>CSS: #{item.css_classes}</p>"
					layout += "\n\t\t\t</div>"
				end
				layout += "\n\t\t</div>"
			else
				container.container_rows.order('position asc').each do |row|
					layout += "\n\t\t<div class=\"row-layout\">"
					layout += "\n\t\t\t<p>Row: #{row.position}</p>"
					layout += "\n\t\t\t<p>CSS: #{row.css_classes}</p>"
					row.row_columns.order('position asc').each do |col|
						layout += "\n\t\t\t<div class=\"col-layout\">"
						layout += "\n\t\t\t\t<p>Column: #{col.position}</p>"
						layout += "\n\t\t\t\t<p>CSS: #{col.css_classes}</p>"
						layout += "\n\t\t\t</div>"
					end
					layout += "\n\t\t</div>"
				end
			end
			layout += "\n\t</div>"
		end
		layout += "\n</div>"
	end

end
