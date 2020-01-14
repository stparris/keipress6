class Theme < ApplicationRecord
	belongs_to :site
	has_many :pages
	has_many :theme_colors

	attr_accessor :new_scss_production, :new_scss_workspace, :syntax_errors

	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: "Name is already in use for this site" }
	validate :new_scss_workspace, on: :update, if: :new_scss_workspace_changed?
	validate :new_scss_production, on: :update, if: :new_scss_production_changed?
	
	before_create :new_scss_production

	def default_scss
		scss = "/**
 Theme 
Created at #{Time.now}	
*/
.#{self.css_class} {

}
"
	end

	def set_scss
		self.new_scss_production = default_scss
		self.new_scss_workspace = default_scss
	end 

# Production scss updated
	def new_scss_production
		@new_scss_production
	end	

	def new_scss_production_changed?
		!@new_scss_production.blank?
	end

	def new_scss_production=(scss)
		css = Theme.generate_css(scss)
		if css =~ /^Syntax Error/
			self.syntax_errors = css
		else
			self.scss_production = scss
			File.open("#{asset_path}/#{asset_name}_production.css", 'w') { |f| f.write(css) }
		end
	end

# Workspace scss updated

	def new_scss_workspace
		@new_scss_workspace
	end

	def new_scss_workspace_changed?
		!@new_scss_workspace.blank?
	end

	def new_scss_workspace=(scss)
		css = Theme.generate_css(scss)
		if css =~ /^Syntax Error/
			self.syntax_errors = css
		else
			@is_valid_syntax = true
			self.scss_workspace = scss
			File.open("#{asset_path}/#{asset_name}_workspace.css", 'w') { |f| f.write(css) }
		end
	end	

	def asset_path
		path = Rails.root.join('public', 'assets')
		unless Dir.exists?(path)
      Dir.mkdir(path,0700)
    end  
    return path
	end

	def asset_name
	  self.css_class.downcase.gsub(/-/,'_')
	end

	def asset_url
	  "/assets/#{asset_name}"
	end

	private

		def self.generate_css(scss)
			css = ""
			begin
				css =	Sass::Engine.new(scss, {
						    syntax: :scss,
						    cache: false,
						    read_cache: false,
						    style: :compressed 
							  }).render
			rescue Exception => e
				css = "Syntax Error: #{e.message} #{e.backtrace[0].sub(/\(sass\)/,'Line')}"
			end
		end

end

