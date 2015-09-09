class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_mixpanel_tracker
    @mixpanel_tracker = Mixpanel::Tracker.new(ENV["MIXPANEL_TOKEN"])
  end
end
