class AdminsSite < ApplicationRecord

	belongs_to :site
	belongs_to :admin

	attr_accessor :site_obj_id, :admin_obj_id

end