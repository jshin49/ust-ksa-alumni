class UserController < ApplicationController
  def index  
    @alumni = get_alumni
    
    @schools = get_schools
    @majors = get_majors_with_declaration     
    @industries = get_industries_with_experience
    
    @entrance_years = get_entrance_years
    @graduation_years = get_graduation_years
    @locations = get_locations
    
    respond_to do |format|
      format.js
      format.html {render layout: 'layouts/user_index'}
    end    
  end
  
  private 
  
  def get_alumni
    if params[:school]
      return User.joins(:majors).where(majors: {school: params[:school]})
    elsif params[:major]
      return User.joins(:majors).where(majors: {code: params[:major]})
    elsif params[:industry]
      return User.joins(:experienced_industries).where(industries: {id: params[:industry]})
    elsif params[:entrance_year]
      date_range = Time.new(params[:entrance_year],1,1)..Time.new(params[:entrance_year],12,31)
      return User.where(entrance_year: date_range)
    elsif params[:graduation_year]
      date_range = Time.new(params[:graduation_year],1,1)..Time.new(params[:graduation_year],12,31)
      return User.where(graduation_year: date_range)
    elsif params[:location] 	
      return User.where(location: params[:location])
    else
      return User.where(status: "alumni")
    end
  end
  
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
    return User.distinct.pluck(:entrance_year).collect(&:year).uniq.sort!
  end
  
  def get_graduation_years
    return User.distinct.pluck(:graduation_year).collect(&:year).uniq.sort!
  end
  
  def get_locations
    return User.distinct.pluck(:location).reject!(&:empty?).sort!  	
  end
  
  def get_schools
    return Major.distinct.pluck(:school)
  end
  
end
