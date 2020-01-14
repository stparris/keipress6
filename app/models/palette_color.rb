class PaletteColor < ApplicationRecord
	belongs_to :palette
	has_many :theme_colors
end
