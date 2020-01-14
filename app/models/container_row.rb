class ContainerRow < ApplicationRecord
	belongs_to :container
	has_many :row_columns, -> { order('position ASC') }

	before_save :prepend_row
	before_create :set_position

	def added_css_classes
		self.css_classes.sub(/^row\s/,'')
	end

	def prepend_row
		self.css_classes = "row #{self.added_css_classes}"
	end

	def set_position
		self.position = ContainerRow.where(container_id: self.container_id).count + 1
	end


end
