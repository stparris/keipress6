class ThemeColor < ApplicationRecord
	belongs_to :theme
	belongs_to :palette_color
end
