class Medium < ApplicationRecord
  belongs_to :site
	has_many :categories_medium
 	has_many :categories, through: :categories_medium
	belongs_to :image

end
