class UserController < ApplicationController
  def index  
    @alumni = User.where(status: "alumni")     
    render layout: 'layouts/user_index'
  end
end
