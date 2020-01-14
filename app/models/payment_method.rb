class PaymentMethod < ApplicationRecord
	belongs_to :site
	belongs_to :payment_type, optional: true
	has_many :bookings
	has_many :rental_payment_methods
	belongs_to :admin_mail_template, :class_name => 'AdminMailTemplate', :foreign_key => :admin_mail_template_id, optional: true    
	belongs_to :user_mail_template, :class_name => 'UserMailTemplate', :foreign_key => :user_mail_template_id, optional: true    


	validates :name, presence: true
	validates :name, uniqueness: { scope: :site_id, message: " is already in use for this site" }


end
