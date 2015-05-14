class UserController < ApplicationController
  def index  
    @alumni = User.where(status: "alumni")
    
    @majors = get_majors_with_declaration     
    
    render layout: 'layouts/user_index'
  end
  
  private 
  
  def get_majors_with_declaration
    unique_major_ids = Declaration.distinct.pluck(:major_id)
    unique_majors = []
    unique_major_ids.each do |id|
      unique_majors << Major.find_by_id(id)
    end
    return unique_majors.sort! {|x,y| x.id <=> y.id}
  end
end
