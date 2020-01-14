class AdminSession
	include ActiveModel::Model
	include ActiveModel::Validations
	include ActiveModel::Conversion

	attr_accessor :id, :email, :password

  def authenticate
    begin
      admin = Admin.find_by(email: self.email)
      if admin
        expected_password = encrypted_password(self.password, admin.salt)
        if admin.hashed_password != expected_password
          admin = nil
        end
      end

      admin
    rescue
      nil
    end
  end

	private

	  def encrypted_password(password, salt)
	    string_to_hash = password + "whippet" + salt
	    Digest::SHA1.hexdigest(string_to_hash)
	  end    

end