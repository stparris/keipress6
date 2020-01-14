class ListGroup < ApplicationRecord
	
	belongs_to :site
	
	has_many :list_group_items
	has_many :navigation_items

	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: " already exists" }
	
	before_save :add_group

	def clear_group
		self.name.sub(/\sGroup$/,'')
	end

	def add_group
		self.name = "#{self.clear_group} Group"
	end

end