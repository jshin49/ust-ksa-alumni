class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :name, presence: true
  validates :entrance_year, presence: true
  validates :graduation_year, presence: true
  
  has_many :interests
  has_many :declarations
  has_many :industries, through: :interests
  has_many :majors, through: :declarations
end
