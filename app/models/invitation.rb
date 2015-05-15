class Invitation < ActiveRecord::Base
	belongs_to :user	
	before_create :create_secret_key
	validates :email, format: {with: /\A([\w\.%\+\-]+)(@ust\.hk\z)|(@connect\.ust\.hk\z)|(@stu\.ust\.hk\z)/i, message: "can invite only UST domains. Ex. connect.ust.hk"} 
	
	private
	
	def create_secret_key
	  begin
    	self.secret_key = SecureRandom.hex(5)
  	  end while self.class.exists?(secret_key: secret_key)
	end
end
