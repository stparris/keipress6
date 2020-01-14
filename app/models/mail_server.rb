class MailServer < ApplicationRecord
	belongs_to :site

	validates :name, presence: true
	validates :name, uniqueness: { :scope => :site_id }	

	after_save :ensure_one_active_server
	
	def connection_config
		config = JSON.parse self.config
		{
		  address: config['address'],
		  port: config['port'],
		  domain: config['domain'],
		  user_name: Rails.application.credentials.sites[config['site'].to_sym][:mailservers][config['server_name'].to_sym][config['username_key'].to_sym],
		  password: Rails.application.credentials.sites[config['site'].to_sym][:mailservers][config['server_name'].to_sym][config['password_key'].to_sym],
		  authentication: config['authentication'],
		  enable_starttls_auto: config['enable_starttls_auto']
		}
	end

	def ensure_one_active_server
		if self.active
			MailServer.where("site_id = #{self.site.id} and id != #{self.id}").update_all(active: false)
		end
	end

end
