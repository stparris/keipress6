class ArtistMedium < ApplicationRecord
	belongs_to :admins
	belongs_to :article
end