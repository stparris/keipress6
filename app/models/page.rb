class Page < ApplicationRecord
	belongs_to :site
	belongs_to :theme
	has_many :containers_pages, -> { order('position ASC') }
	has_many :containers, through: :containers_pages

	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id }	
	validates :nice_url, uniqueness: { scope: :site_id }

	attr_accessor :muparams

	before_save :gen_nice_url

	def gen_nice_url
		unless self.nice_url =~ /\S+/
			# horrible name: %q#  ^This is a (sort of ["really"], kind of) {terrible} title! /m&m\ @ 50% #
			nice_url = self.name.strip.gsub(/\@/," at ").gsub(/\&/," and ").gsub(/\%/," percent ").gsub(/[^A-Za-z0-9\s+]/,' ').gsub(/_|\./,'-')
    	self.nice_url = nice_url.split(/\s+/).map(&:downcase).join('-').gsub(/-+/,"-").sub(/^-|-$/,'')
    	# yields: "this-is-a-sort-of-really-kind-of-terrible-title-m-and-m-at-50-percent"
			# with parameterize: "this-is-a-sort-of-really-kind-of-terrible-title-m-m-50"
		end
	end

end
