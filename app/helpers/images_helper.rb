module ImagesHelper
	
	def optimize_td(image)
		html = ""
		size = image.image.blob.byte_size ? image.image.blob.byte_size : 0
		if size > 500000
			html = "<td style=\"background-color:#ffb399\">"
			html +=	link_to raw("<icon class=\"icon-emo-angry\"></icon> #{size}"), edit_admin_image_optimization_path(image)
			html +=	"</td>"
		elsif size > 200000
			html = "<td style=\"background-color:#ffb366\">"
			html += link_to raw("<icon class=\"icon-emo-surprised\"></icon> #{size}"), edit_admin_image_optimization_path(image)
			html +=	"</td>"
		elsif size > 100000			
			html = "<td style=\"background-color:#ffffb3\">"
			html +=	link_to raw("<icon class=\"icon-emo-unhappy\"></icon> #{size}"), edit_admin_image_optimization_path(image)
			html +=	"</td>"
		else
			html = "<td style=\"background-color:#ccffcc\">"
			html +=	raw("<icon class=\"icon-emo-happy\"></icon> #{size}")
			html +=	"</td>"	
		end
		html.html_safe
	end

	def optimize_div(image)
		html = ""
		message = image.quality ? " This image has been optimized." : ""
		size = image.image.blob.byte_size ? image.image.blob.byte_size : 0
		if size > 500000
			html = "<div style=\"padding:5px;width:100%;background-color:#ffb399\">"
			html +=	raw("<icon class=\"icon-emo-angry\"></icon> #{size} bytes. #{message}")
			html +=	"</div>"
		elsif size > 200000
			html = "<div style=\"padding:5px;width:100%;background-color:#ffb366\">"
			html += raw("<icon class=\"icon-emo-surprised\"></icon> #{size} bytes. #{message}")
			html +=	"</div>"
		elsif size > 100000			
			html = "<div style=\"padding:5px;width:100%;background-color:#ffffb3\">"
			html +=	raw("<icon class=\"icon-emo-unhappy\"></icon> #{size} bytes. #{message}")
			html +=	"</div>"
		else
			html = "<div style=\"padding:5px;width:100%;background-color:#ccffcc\">"
			html +=	raw("<icon class=\"icon-emo-happy\"></icon> #{size} bytes. #{message}")
			html +=	"</div>"	
		end
		html.html_safe
	end

  def image_width_options(max_width)
  	options = {}
  	if max_width.to_i >= 1915
  		options['1920px Full width HD Displays'] = '1920'
  		options['1600px'] = '1600'
  		options['1366px'] = '1366'
  		options['1024px'] = '1024'
  	elsif max_width.to_i >= 1590
			options['1600px'] = '1600'
			options['1366px'] = '1366'
			options['1024px'] = '1024'
 		elsif max_width.to_i >= 1356
			options['1366'] = '1366'
			options['1024px'] = '1024'
	 	elsif max_width.to_i >= 1014
			options['1024px'] = '1024'
 		end
 		options['768px'] = '768'
 		return options
  end

	def src_sets(image,img_class=nil)
		css = img_class ? img_class : 'img-fluid'
		srcset = []
		img_src = url_for(image.image)
		if image.max_width.to_i >= 1920
			srcset << [url_for(image.image.variant(resize: '1600x1600')), "1600w"]
			srcset << [url_for(image.image.variant(resize: '1366x1366')), "1366w"]
			srcset << [url_for(image.image.variant(resize: '1024x1024')), "1024w"]
		elsif image.max_width.to_i >= 1600
			srcset << [url_for(image.image.variant(resize: '1366x1366')), "1366w"]
			srcset << [url_for(image.image.variant(resize: '1024x1024')), "1024w"]
		elsif image.max_width.to_i >= 1366
			srcset << [url_for(image.image.variant(resize: '1024x1024')), "1024w"]
		end
		srcset << [url_for(image.image.variant(resize: '768x768')), "768w"]
		srcset << [url_for(image.image.variant(resize: '640x640')), "640w"]
		image_tag(img_src, srcset: srcset, class: css )
	end


end
