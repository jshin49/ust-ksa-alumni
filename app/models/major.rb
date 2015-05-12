class Major < ActiveRecord::Base
	has_many :declarations
	has_many :users, through: :declarations
end
