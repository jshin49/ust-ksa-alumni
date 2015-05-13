class Industry < ActiveRecord::Base
	has_many :interests
	has_many :experiences
	has_many :users, through: :interests
	has_many :users, through: :experiences
end
