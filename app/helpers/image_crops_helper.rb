module ImageCropsHelper
	def cacheBustUrl(url)
		"#{url}?#{Time.now.to_i}"
	end

end
