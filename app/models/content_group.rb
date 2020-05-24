class ContentGroup < Content

	has_many :content_group_items, -> { order(position: :asc) }, foreign_key: "content_id", class_name: "ContentGroupItem"


	before_save :add_group

	def clear_group
		self.name.sub(/\sGroup$/,'') if self.name
	end

	def add_group
		self.name = "#{self.clear_group} Group" unless self.name =~ /Group$/
	end


end
