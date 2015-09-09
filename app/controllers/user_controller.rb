class UserController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :set_mixpanel_tracker, only: [:index]

  def index
    total_students = get_users_from_params
    @alumni = total_students.where(status:"alumni").uniq
    @current_students = total_students.where(status:"current").uniq

    @schools = get_schools
    @majors = get_majors_with_declaration
    @industries = get_industries_with_experience

    @entrance_years = get_entrance_years
    @graduation_years = get_graduation_years
    @locations = get_locations

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @user = User.find_by_id params[:id]
    if @user.status != "alumni"
      redirect_to users_url
    end
  end

  def autocomplete_organization
    if params[:term]
      @organizations = User.where("lower(organization) like lower(?)", "%#{params[:term]}%").collect(&:organization).uniq
    end
    render json: @organizations
  end

  def autocomplete_location
    if params[:term]
      @locations = User.where("lower(location) like lower(?)", "%#{params[:term]}%").collect(&:location).uniq
    end
    render json: @locations
  end

  private

  def get_users_from_params
    if params[:school]
      @mixpanel_tracker.track(current_user.id, "Index", {"filter" => "school", "keyword" => params[:school]})
      return User.joins(:majors).where( majors: {school: params[:school]})
    elsif params[:major]
      @mixpanel_tracker.track(current_user.id, "Index", {"filter" => "major", "keyword" => params[:major]})
      return User.joins(:majors).where(majors: {id: params[:major]})
    elsif params[:industry]
      @mixpanel_tracker.track(current_user.id, "Index", {"filter" => "industry", "keyword" => params[:industry]})
      return User.joins(:experienced_industries).where(industries: {id: params[:industry]})
    elsif params[:entrance_year]
      @mixpanel_tracker.track(current_user.id, "Index", {"filter" => "entrance_year", "keyword" => params[:entrance_year]})
      date_range = Time.new(params[:entrance_year],1,1)..Time.new(params[:entrance_year],12,31)
      return User.where(entrance_year: date_range)
    elsif params[:graduation_year]
      @mixpanel_tracker.track(current_user.id, "Index", {"filter" => "graduation_year", "keyword" => params[:graduation_year]})
      date_range = Time.new(params[:graduation_year],1,1)..Time.new(params[:graduation_year],12,31)
      return User.where(graduation_year: date_range)
    elsif params[:location]
      @mixpanel_tracker.track(current_user.id, "Index", {"filter" => "location", "keyword" => params[:location]})
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
    sort_list User.distinct.pluck(:entrance_year).collect(&:year).uniq
  end

  def get_graduation_years
    sort_list User.distinct.pluck(:graduation_year).collect(&:year).uniq
  end

  def get_locations
    sort_list User.distinct.pluck(:location).reject(&:empty?)
  end

  def get_schools
    return Major.distinct.pluck(:school)
  end

  def sort_list(list)
    if list.nil?
      []
    else
      list.sort!
    end
  end

end
