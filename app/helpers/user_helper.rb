module UserHelper
  def is_linkedin_connected
    !(current_user.auth_token.nil? || current_user.provider.nil?)
  end

  def get_location(name)
    if name == "HK" || name == "Hong Kong" || name == "hong kong"
      return "Hong Kong"
    end
    if name == "Seoul Korea" || name == "Seoul, Korea"
      return "Seoul"
    end
    return name
  end
end
