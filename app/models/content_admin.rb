class ContentAdmin < ApplicationRecord
	belongs_to :admin
	belongs_to :content
end
