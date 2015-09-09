class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :default_values


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:linkedin]


  validates :name, presence: true
  validates :entrance_year, presence: true
  validates :graduation_year, presence: true
  validates :email, presence: true
  validates_with EntranceGraduationYearValidator

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

  def majors_text
    text_format(majors)
  end

  def experienced_industries_text
    text_format(experienced_industries)
  end

  def interested_industries_text
    text_format(interested_industries)
  end

  private

  def text_format(array)
    if array.nil?
      return ""
    end
    if array.first.nil?
      s = ""
    else
      s = array.first.name
    end
    if array.count == 1
      return s
    end
    for i in 1..array.count-1
      unless array[i].name.nil?
        s += (" / " + array[i].name)
      end
    end
    return s
  end

  def default_values
    self.location ||= ""
  end
end
