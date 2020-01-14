class Container < ApplicationRecord

	belongs_to :site
	belongs_to :navigation, optional: true
	belongs_to :medium, optional: true
	belongs_to :image, optional: true
	belongs_to :carousel, optional: true
	belongs_to :content_group, optional: true
	has_many :containers_pages
	has_many :container_rows, -> { order('position ASC') }

	attr_accessor :container_css
	attr_accessor :container_fluid

	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: " is already in use for this site" }

	before_save :prepend_container_css

	def is_container_fluid?
		self.css_classes =~ /fluid/ ? true : false
	end

	def set_container
		if self.container_type =~ /carousel|nav/
			''
		else
			self.container_fluid == 'yes' ? 'container-fluid' : 'container'
		end
	end

	def set_jumbotron
		self.container_css == 'jumbotron' ? ' jumbotron ' : ' '
	end

	def added_css_classes
		self.css_classes.sub(/^container\s|^container-fluid\s|jumbotron\s/,'')
	end

	def prepend_container_css
		container_css = self.container_css ? self.container_css : 'container'
		self.css_classes = "#{set_container}#{set_jumbotron}#{self.added_css_classes}"
	end

end

