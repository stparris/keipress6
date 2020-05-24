class ImageGroup < ApplicationRecord
	belongs_to :site
	has_many :row_columns
  has_many :image_group_items, -> { order('position ASC') }
  has_many :image_batches

	before_validation :add_group

	validates :name, presence: true
	validates :name, uniqueness: { :scope => :site_id, message: "Group name is already in use." }

	def clear_group
		self.name.sub(/\sGroup$/,'')
	end

	def add_group
		self.name = "#{self.clear_group} Group" unless self.name =~ /Group$/
	end

end
