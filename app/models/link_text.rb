class LinkText < ApplicationRecord

	belongs_to :site
	has_many :navigation_items
	has_many :dropdown_items
	has_many :list_group_items
	has_many :content_items

	attr_accessor :http_https
	
	before_save :prepend_http_https

	def link_stub
		self.link.sub(/^http\S*:\/\//,'') if self.link
	end

	def prepend_http_https
		if self.http_https
			self.link = "#{self.http_https}://#{link_stub}"
		else
			self.link = 'n/a'
		end
	end

end
