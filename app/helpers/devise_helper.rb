module DeviseHelper
  def devise_error_messages!
    password_msg = ""
    resource.errors.full_messages_for(:password).each do |msg|
       password_msg += msg;
    end
    flash[:password_error] = password_msg

    resource.errors.full_messages_for(:graduation_year).each do |msg|
      flash[:graduation_year_error] = msg;
    end

    resource.errors.full_messages_for(:name).each do |msg|
      flash[:name_error] = msg;
    end
    return ""
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end
