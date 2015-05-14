class UserController < ApplicationController
  def index  
    @alumni = User.where(status: "alumni")
    
    @majors = get_majors_with_declaration     
    @industries = get_industries_with_experience
    
    @entrance_years = get_entrance_years
    @graduation_years = get_graduation_years
    
    render layout: 'layouts/user_index'
  end
  
  private 
  
  def get_industries_with_experience
    unique_industries_ids = Experience.distinct.pluck(:industry_id)
    unique_industries = []
    unique_industries_ids.each do |id|
      unique_industries << Industry.find_by_id(id)
    end
    return unique_industries.sort! {|x,y| x.name <=> y.name}
  end
  
  def get_majors_with_declaration
    unique_major_ids = Declaration.distinct.pluck(:major_id)
    unique_majors = []
    unique_major_ids.each do |id|
      unique_majors << Major.find_by_id(id)
    end
    return unique_majors.sort! {|x,y| x.id <=> y.id}
  end
  
  def get_entrance_years
    return User.distinct.pluck(:entrance_year).collect {|i| i.year}.uniq.sort!
  end
  
  def get_graduation_years
    return User.distinct.pluck(:graduation_year).collect {|i| i.year}.uniq.sort!
  end
end
