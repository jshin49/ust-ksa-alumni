class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :default_values

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :name, presence: true
  validates :entrance_year, presence: true
  validates :graduation_year, presence: true
  
  has_many :interests, dependent: :destroy
  has_many :declarations, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :invitations, dependent: :destroy
  
  has_many :interested_industries, through: :interests,
           class_name: "Industry",
           source: :industry
  has_many :experienced_industries, through: :experiences,
           class_name: "Industry",
           source: :industry
  has_many :majors, through: :declarations
  
  private
  
  def default_values
    self.location ||= ""
  end
end
