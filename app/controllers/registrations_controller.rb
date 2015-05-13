class RegistrationsController < Devise::RegistrationsController
 
  def edit
    @ssc = Major.where(school: "School of Science")
    @seng = Major.where(school: "School of Engineering")
    @sbm = Major.where(school: "School of Business")
    @huma = Major.where(school: "School of Humanities and Social Science")
    @ipo = Major.where(school: "Interdisciplinary Programs Office")
    
    @favorite_industries = Industry.where(favorite:true)
    @other_industries = Industry.where(favorite:false)
    
    @ticked_majors = current_user.majors
    @ticked_industries = current_user.industries
  end
  
  def update
    if params[:major_ids]
      majors = []
      params[:major_ids].each do |major_id|
        majors << Major.find_by_id(major_id)
      end
      current_user.majors = majors
    end
    
    if params[:industry_ids]
      industries = []
      params[:industry_ids].each do |industry_id|
        industries << Industry.find_by_id(industry_id)
      end   
      current_user.industries = industries
    end
    
    if current_user.save
      flash[:notice] = "Update Complete"
      redirect_to root_path
    else
      render edit_user_registration_path
    end
  end
  
  private
  
  def sign_up_params
    params.require(:user).permit(:name, :entrance_year, :graduation_year, :email, :password, :password_confirmation,)
  end
  
  def account_update_params
    params.require(:user).permit(:name, :entrance_year, :graduation_year, :email, :password, :password_confirmation, :current_password)
  end

end