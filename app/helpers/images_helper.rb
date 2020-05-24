module ImagesHelper

	require 'json'

	def optimize_td(image)
		html = ""
		size = image.image.blob.byte_size ? image.image.blob.byte_size : 0
		if size > 500000
			html = "<td style=\"background-color:#ffb399\">"
			html +=	link_to raw("<icon class=\"icon-emo-angry\"></icon> #{size}"), edit_admin_image_optimization_path(image)
			html +=	"</td>"
		elsif size > 300000
			html = "<td style=\"background-color:#ffb366\">"
			html += link_to raw("<icon class=\"icon-emo-surprised\"></icon> #{size}"), edit_admin_image_optimization_path(image)
			html +=	"</td>"
		elsif size > 175000
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
		max_width = image.image.blob.metadata['width']
		html = ""
		message = image.quality ? " This image has been optimized." : ""
		size = image.image.blob.byte_size ? image.image.blob.byte_size : 0
		if size > 500000
			html = "<div class=\"image-bytes-angry\" style=\"max-width: #{max_width}px\">"
			html +=	raw("<icon class=\"icon-emo-angry\"></icon> #{size} bytes. #{message}")
		elsif size > 300000
			html = "<div class=\"image-bytes-surprised\" style=\"max-width: #{max_width}px\">"
			html += raw("<icon class=\"icon-emo-surprised\" style=\"max-width: #{max_width}px\"></icon> #{size} bytes. #{message}")
		elsif size > 175000
			html = "<div class=\"image-bytes-unhappy\">"
			html +=	raw("<icon class=\"icon-emo-unhappy\" style=\"max-width: #{max_width}px\"></icon> #{size} bytes. #{message}")
		else
			html = "<div class=\"image-bytes-happy\" style=\"max-width: #{max_width}px\">"
			html +=	raw("<icon class=\"icon-emo-happy\"></icon> #{size} bytes. #{message}")
		end
		html +=	"</div>"
		html += "<h6>Source: #{image.image.blob.filename}</h6>"
		image_hash = JSON.parse(image.image.blob.metadata.to_json)
		html += "<h6>Max dimensions: width #{image_hash['width']}px, height #{image_hash['height']}px</h6>"
		html.html_safe
	end

	def file_size_div(size, max_width)
		html = ""
		if size > 500000
			html = "<div class=\"image-bytes-angry\" style=\"max-width: #{max_width}px\">"
			html +=	raw("<icon class=\"icon-emo-angry\"></icon> #{size} bytes.")
		elsif size > 300000
			html = "<div class=\"image-bytes-surprised\" style=\"max-width: #{max_width}px\">"
			html += raw("<icon class=\"icon-emo-surprised\"></icon> #{size} bytes.")
		elsif size > 175000
			html = "<div class=\"image-bytes-unhappy\" style=\"max-width: #{max_width}px\">"
			html +=	raw("<icon class=\"icon-emo-unhappy\"></icon> #{size} bytes.")
		else
			html = "<div class=\"image-bytes-happy\" style=\"max-width: #{max_width}px\">"
			html +=	raw("<icon class=\"icon-emo-happy\"></icon> #{size} bytes.")
		end
		html +=	"</div>"
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

	def src_sets(image,parent=nil,img_class=nil)
		alt = parent ? parent.name : image.name
		title = parent ? parent.caption : image.caption
		if image && image.image.attached?
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
			image_tag(img_src, srcset: srcset, alt: "#{alt}", title: "#{title}",  class: css )
		end
	end


end
