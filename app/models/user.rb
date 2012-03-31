require 'digest/sha2'

class User < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	#confirmation makes 2 fields for validation
	validates :password, :confirmation => true
	#Behind the scenes the attr_accessor generates 2 accessor
	#methods: a reader called password and a writer called 
	#password=. The fact that it ends in an = means that it
	#can be assigned to.
	attr_accessor :password_confirmation
	attr_reader   :password

	#We do not test for the actual password, but rather the 
	#proxy of the hashed password in the database
	validate :password_must_be_present
	after_destroy :ensure_an_admin_remains

#This method generates an exception to indicate that there is 
#an error. Since the delete action was raised inside a 
#transaction, it causes automatic rollback. The user that was
#deleted is rolled back into the system. We will use begin/end
#block to handle the error in the flash
	def ensure_an_admin_remains
		if User.count.zero?
			raise "Can't delete last user"
		end
	end

	def ensure_an_admin_exists
		if User.count.zero?
			
		end
	end

#This returns the user object if the correct information is 
#supplied. Since the incoming password is in plain text, we have
#to read the user record using the name and the key and then
#user the salt value in that record to construct the hashed password
#again. Then return object.
	def User.authenticate(name, password)
		if user = find_by_name(name)
			if user.hashed_password == encrypt_password(password, user.salt)
				user
			end
		end
	end

	#In cryptography, salt string are random bits used to make
	#it harder to crack the password
	def User.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "wibble" + salt)
	end


	#the attr_accessor is calling this
	def password=(password)
		@password = password

		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end



	private

	def password_must_be_present
		errors.add(:password, "Missing Password") unless hashed_password.present?
	end

#self.salt forces the assignment to use the salt= accessor 
#method - we are saying to call the method salt= in the current
#object. Without self, Ruby would have thought that we were 
#assigning to a local variable, and our code would have no effect.
	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

	



end
