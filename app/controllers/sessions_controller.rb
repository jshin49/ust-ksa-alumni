class SessionsController < Devise::SessionsController

	before_filter :track_logout_action, only: [:destroy]
	before_filter :track_login_action, only: [:create]

	protected

	def track_login_action
		set_mixpanel_tracker
		@mixpanel_tracker.track(current_user.id, "Login")
	end

	def track_logout_action
		set_mixpanel_tracker
		@mixpanel_tracker.track(current_user.id, "Logout")
	end

	def after_sign_in_path_for(resource)
		if (resource.status.nil?)
			edit_user_registration_path
		else
			super
		end
	end
end
