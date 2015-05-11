class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :name, presence: true
  validates :entrance_year, presence: true
  validates :graduation_year, presence: true
  	
  #User.where("#{User.interests[:IT]} = ANY (interests)")
end
