class Content < ApplicationRecord
	belongs_to :site
	has_many :content_items
	has_many :containers
	has_many :row_columns
 	has_many :categories_content
 	has_many :categories, through: :categories_content

	validates :name, presence: true
	validates :name, uniqueness: { :scope => :site_id, message: " is already in use." }

	def self.site_text_items(site_id)
		self.where(site_id: site_id).includes(:content_items).where("content_items.content_type = 'text' or content_items.content_type = 'html'").references(:content_items).order('contents.name asc')
	end

end
