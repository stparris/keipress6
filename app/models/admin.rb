class Admin < ApplicationRecord
  
  has_many :admins_sites
  has_many :sites, through: :admins_sites

  attr_accessor :new_password

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates_confirmation_of :new_password, :if=>:password_changed?
  validate :password_non_blank
  validate :role_allowed

  attr_accessor :parent_admin

  before_save :set_admin_type

	def full_name
		full_name = ""
		full_name += "#{self.prefix} " if self.prefix =~ /\S+/
		full_name += "#{self.first_name} " if self.first_name =~ /\S+/ 
		full_name += "#{self.middle_name} " if self.middle_name =~ /\S+/ 
		full_name += "#{self.last_name} " if self.last_name =~ /\S+/ 
		full_name += self.suffix if self.suffix =~ /\S+/ 
		return full_name
	end

  def new_password
    @new_password
  end

  def new_password=(pwd)
    @new_password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Admin.encrypted_password(self.new_password, self.salt)
  end

  def password_changed?
    !@new_password.blank?
  end

  def before_destroy
    if Admin.count.zero?
      raise "Can't delete last user"
    end
  end     

  def set_admin_type
    self.admin_type = "Super Admin" if self.role == 1
    self.admin_type = "Site Admin" if self.role == 2
    self.admin_type = self.admin_type ? self.admin_type : "Content Admin"
  end

  def role_allowed
    if self.parent_admin && self.role == 1 && self.parent_admin.role != 1
      errors.add(:role, "Super user not allowed")
    end
  end

private

  def password_non_blank
    errors.add(:new_password, "Missing password") if hashed_password.blank?
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "whippet" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end    

end
