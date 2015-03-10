class User < ActiveRecord::Base
	attr_accessor :password
	has_one :profiles

	before_save :encrypt_password
	after_save :clear_password

	#validates_confirmation_of :password
  	#attr_accessible :password_confirmation
  	#attr_accessor :password

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email, :presence => true, :uniqueness => true, :length => { :in => 3..20 }, :format => EMAIL_REGEX
	#validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true #password_confirmation attr
	validates_length_of :password, :in => 6..20, :on => :create 


	#attr_accessible :email, :password, :password_confirmation


	def self.authenticate(username_or_email="", login_password="")
		if  EMAIL_REGEX.match(username_or_email)    
		  user = User.find_by_email(username_or_email)
		else
		  user = User.find_by_username(username_or_email)
		end

		if user && user.match_password(login_password)
		  return user
		else
		  return false
		end
	end   

	def match_password(login_password="")
		pass == BCrypt::Engine.hash_secret(login_password, salt)
	end



	def encrypt_password
	unless password.blank?
	  self.salt = BCrypt::Engine.generate_salt
	  self.pass = BCrypt::Engine.hash_secret(password, salt)
	end
	end

	def clear_password
		self.password = nil
	end
end
