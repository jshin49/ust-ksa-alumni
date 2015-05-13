class UserController < ApplicationController
  def index  
    @alumni = User.where(status: "alumni")     
  end
end
