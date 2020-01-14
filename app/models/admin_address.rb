class AdminAddress < ApplicationRecord
	belongs_to :admin
	belongs_to :state
	belongs_to :country

end
