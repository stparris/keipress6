class Medium < ApplicationRecord
	has_many :categories_medium
 	has_many :categories, through: :categories_medium

	has_one_attached :image
	has_one_attached :song
	has_one_attached :video

end
