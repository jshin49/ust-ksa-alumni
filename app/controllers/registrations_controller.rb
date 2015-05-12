class RegistrationsController < Devise::RegistrationsController
 
 def edit
  @ssc = Major.where(school: "School of Science")
  @seng = Major.where(school: "School of Engineering")
  @sbm = Major.where(school: "School of Business")
  @huma = Major.where(school: "School of Humanities and Social Science")
  @ipo = Major.where(school: "Interdisciplinary Programs Office")
  
  @favorite_industries = Industry.where(favorite:true)
  @other_industries = Industry.where(favorite:false)
  
 end
 
 private

  def sign_up_params
    params.require(:user).permit(:name, :entrance_year, :graduation_year, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :entrance_year, :graduation_year, :email, :password, :password_confirmation, :current_password)
  end

end