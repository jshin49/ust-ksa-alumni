module UserHelper
  def is_linkedin_connected
    !(current_user.auth_token.nil? || current_user.provider.nil?)
  end
end
