require 'mixpanel-ruby'

class RegistrationsController < Devise::RegistrationsController
  before_filter :set_mixpanel_tracker
  before_filter :track_cancel_account, only: [:destroy]
  def new
    if params[:secret_key] && !Invitation.where(secret_key: params[:secret_key]).nil?
      	@invitation = Invitation.where(secret_key: params[:secret_key])
        if !@invitation.any?
          flash[:error] = "Invitation is invalid.\n\nPlease sign in or get another invitation"
          redirect_to new_user_session_path
          return ;
        end
        @user = User.new
        @user.email = @invitation.first.email
        @mixpanel_tracker.track(@user.id, "Entered Sign Up")
    else
      redirect_to need_invite_path
    end
  end

  def edit
    @mixpanel_tracker.track(current_user.id, "Click Update Profile")

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
    if params[:disconnect_linkedin]
      current_user.auth_token = nil
      current_user.provider = nil
    else

      current_user.status = determine_status(Date.civil(params[:user]["graduation_year(1i)"].to_i,params[:user]["graduation_year(2i)"].to_i))

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
    end

    if current_user.save
      flash[:notice] = "Successfully Updated!"

      #update status to mixpanel
      @mixpanel_tracker.people.append(current_user.id, {
        "status" => current_user.status,
        "location" => current_user.location
      })
      @mixpanel_tracker.track(@user.id, "Update Profile")
      redirect_to users_path
    else
      error_msg = "Could Update information.\n"
      current_user.errors.full_messages.each do |msg|
          error_msg += "\n" + msg
      end
      flash[:error] = error_msg
      redirect_to edit_user_registration_path
    end
  end

  def create
    super
    if User.find_by_email(@user.email)
      Invitation.where(email: @user.email).destroy_all
    end

    @mixpanel_tracker.people.set(@user.id, {
      "email" => @user.email,
      "entrance_year" => @user.entrance_year,
      "graduation_year" => @user.graduation_year})
    @mixpanel_tracker.alias(@user.id, @user.id)
    @mixpanel_tracker.track(@user.id, "Sign Up")
  end

  def need_invite
    @mixpanel_tracker.track("", "Need Invite")
  end

  protected

  def track_cancel_account
    @mixpanel_tracker.track(current_user.id, "Cancel Account")
  end

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
