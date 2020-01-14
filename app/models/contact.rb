class Contact 
	include ActiveModel::Model
	include ActiveModel::Validations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  attr_accessor :site_id, :first_name, :last_name, :email, :details

end