class UserAddress < ApplicationRecord
	belongs_to :user
	belongs_to :state, optional: true
	belongs_to :country

	validates :user_id, presence: true, uniqueness: { :scope => :name }

	before_create :set_name

	def set_name
		self.name = 'primary'
	end
	
end
