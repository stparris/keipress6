class Domain < ApplicationRecord
	belongs_to :site
	
	validates :name, presence: true
  validates :name, uniqueness: true
  validates :site_id, presence: true

end
