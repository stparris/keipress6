class Palette < ApplicationRecord
	has_many :palette_colors
	attr_accessor :color_list
	validates_presence_of :name
end
