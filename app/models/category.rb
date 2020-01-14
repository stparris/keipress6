class Category < ApplicationRecord

	belongs_to :site
	has_many :categories_contents
	has_many :contents, through: :categories_contents
	has_many :categories_images
	has_many :images, through: :categories_images
	has_many :categories_meduim
	has_many :media, through: :categories_medium

	validates :name, presence: true
	validates :name, uniqueness: { :scope => :site_id }	
	validates :nice_url, uniqueness: { scope: :site_id, message: "The URL >> %{nice_url} << generated from the category name is already in use." }

	before_validation :gen_nice_url

	def gen_nice_url
		# horrible name: %q#  ^This is a (sort of ["really"], kind of) {terrible} title! /m&m\ @ 50% #
		nice_url = self.name.strip.gsub(/\@/," at ").gsub(/\&/," and ").gsub(/\%/," percent ").gsub(/[^A-Za-z0-9\s+]/,' ').gsub(/_|\./,'-')
    self.nice_url = nice_url.split(/\s+/).map(&:downcase).join('-').gsub(/-+/,"-").sub(/^-|-$/,'')
	end

end




