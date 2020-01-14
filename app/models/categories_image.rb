class CategoriesImage < ApplicationRecord
	belongs_to :category
	belongs_to :image

end