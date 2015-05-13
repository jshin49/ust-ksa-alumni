class RegistrationsController < Devise::RegistrationsController
 
  def edit
    @status = determine_status(current_user.graduation_year)
  
    @ssc = Major.where(school: "School of Science")
    @seng = Major.where(school: "School of Engineering")
    @sbm = Major.where(school: "School of Business")
    @huma = Major.where(school: "School of Humanities and Social Science")
    @ipo = Major.where(school: "Interdisciplinary Programs Office")
    
    @favorite_industries = Industry.where(favorite:true)
    @other_industries = Industry.where(favorite:false)
    
    @ticked_majors = current_user.majors
    @ticked_interested_industries = current_user.interested_industries
    @ticked_experienced_industries = current_user.experienced_industries
    
  end
  
  def update
    current_user.status = determine_status(current_user.graduation_year)
    
    if params[:user][:location]
      current_user.location = params[:user][:location]
    end
    
    if params[:user][:organization]
      current_user.organization = params[:user][:organization]
    end
    

    current_user.entrance_year = Date.civil(params[:user]["entrance_year(1i)"].to_i, params[:user]["entrance_year(2i)"].to_i)
    current_user.graduation_year = Date.civil(params[:user]["graduation_year(1i)"].to_i,params[:user]["graduation_year(2i)"].to_i)
    
    if params[:major_ids]
      majors = []
      params[:major_ids].each do |major_id|
        majors << Major.find_by_id(major_id)
      end
      current_user.majors = majors
    end
    
    if params[:interested_industry_ids]
      industries = []
      params[:interested_industry_ids].each do |industry_id|
        industries << Industry.find_by_id(industry_id)
      end   
      current_user.interested_industries = industries
    end
    
    if params[:experienced_industry_ids]
      industries = []
      params[:experienced_industry_ids].each do |industry_id|
        industries << Industry.find_by_id(industry_id)
      end   
      current_user.experienced_industries = industries
    end
    
    if current_user.save
      flash[:notice] = "Update Complete"
      redirect_to root_path
    else
      render edit_user_registration_path
    end
  end
  
  protected
  
  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end
  
  private
  
  def determine_status(graduation_date)
    if (graduation_date.to_date.future?)
      "current"
    else
      "alumni"
    end
  
  end
  
  def sign_up_params
    params.require(:user).permit(:name, :entrance_year, :graduation_year, :email, :password, :password_confirmation,)
  end
  
  def account_update_params
    params.require(:user).permit(:name, :entrance_year, :graduation_year, :email, :password, :password_confirmation, :current_password)
  end

end