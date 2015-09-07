class SessionsController < Devise::SessionsController

	protected

	def after_sign_in_path_for(resource)
		if (resource.status.nil?)
			edit_user_registration_path
		else
			super
		end
	end
end
