class User < ApplicationRecord

  belongs_to :site
  has_many :user_addresses
  has_many :bookings

  attr_accessor :new_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { :scope => :site_id }  
  validates_confirmation_of :new_password, :if=>:password_changed?
  validate :password_non_blank

  before_destroy :delete_events

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

  def delete_events
    self.bookings.each do |booking|
      if booking.rental.calendar.parent == true
        booking.site.calendars.each do |cal|
          cal.delete_event(booking.uuid)
        end
      else
        booking.rental.calendar.delete_event(booking.uuid)
        parent = Calendar.find_by(parent: true)
        parent.delete_event(booking.uuid) if parent
      end
    end
  end

  def primary_address
    self.user_addresses.find_by(name: 'primary')
  end

  def billing_address
    self.user_addresses.find_by(name: 'billing')
  end

  def card_address
    self.user_addresses.find_by(name: 'card')
  end

  def shipping_address
    self.user_addresses.find_by(name: 'shipping')
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

