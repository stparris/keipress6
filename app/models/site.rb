class Site < ApplicationRecord
  has_many :domains
	has_many :themes
	has_many :pages
	has_many :categories
	has_many :calendars
	has_many :rentals

	has_many :containers
	has_many :navigations
	has_many :list_groups
	has_many :dropdowns
	has_many :link_texts

	has_many :contents
	has_many :articles
	has_many :blogs

	has_many :images
	has_many :image_groups
	has_many :carousels
	has_many :media

	has_many :mail_servers
	has_many :payment_gateways
	has_many :admins_sites
	has_many :admins, through: :admins_sites

#	has_and_belongs_to_many :admins

	validates :name, presence: true
  validates :name, uniqueness: true

  def self.locales 
  	{
  		'English'=>'en',
  		'Nederlands'=>'nl'
  	}
  end

  def sym_name
  	self.name.downcase.gsub(/[^a-z0-9]|/, '').to_sym
  end

	def gen_error_mail_template
		error_template = MailTemplate.new
    error_template.name = 'Admin Error Reporting'
    error_template.site_id = self.id
   	error_template.recipient_type = 'admin'
   	error_template.template_type = 'error'
    error_template.from_email = self.admins.first.email
    error_template.subject = "System Error #{self.name}"
    error_template.body_html = '<p>{{details}}</p>'
    error_template.body_text = '{{details}}'
    error_template.save!
	end

	def page_assignments
		lang = {'English' => 'en','Nederlands'=>'nl'}
		options = {}
		options['N/A'] = 'n/a'
		possible = ['home','articles']
		possible.each do |p|
			options[p.capitalize] = p 
		end
		self.blogs.order('name asc').each do |blog|
			options["Blog #{blog.name}"] = "blog:#{cal.id}"
		end
		lang.each do |k,v|
			self.rentals.order('name asc').each do |rental|
				options["Booking for #{k} #{rental.name}"] = "booking-#{v}-rental:#{rental.id}"
			end 
		end
=begin
		Category.where(site_id: @site.id).order('name asc').each do |cat|
			options["Category #{cat.name}"] = "category:#{cat.id}"
		end
=end
		options
	end

end
