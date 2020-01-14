class MailTemplate < ApplicationRecord
	belongs_to :site

	validates :name, presence: true
	validates :name, uniqueness: { :scope => :site_id, message: " name is already in use." }
	validates :recipient_type, presence: true
	validates :template_type, presence: true
	before_create :set_locale

	def set_locale
		self.locale = 'en' unless self.locale =~ /\S+/
	end


end

