class CallbacksController < Devise::OmniauthCallbacksController
   
   	# https://www.digitalocean.com/community/tutorials/how-to-configure-devise-and-omniauth-for-your-rails-application
    def linkedin
        @user = from_omniauth(request.env["omniauth.auth"])
        redirect_to edit_registration_path(@user)
    end
    
  # http://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/
  def from_omniauth(auth_hash)
    user = current_user
    user.location = auth_hash['info']['location']['name']
    user.profile_pic_url = auth_hash['extra']['raw_info']['pictureUrls']['values'].first
    user.position = auth_hash['extra']['raw_info']['headline']
    user.linkedin_url = auth_hash['info']['urls']['public_profile']  
    user.save!
    return user
  end

end