require 'mixpanel-ruby'

class InvitationsController < ApplicationController
    before_action :authenticate_user!, only: [:new]
    before_action :set_mixpanel_tracker, only: [:new, :create]
   # GET /invitations/new
  def new
    @invitation = Invitation.new

    @mixpanel_tracker.track(current_user.id, "Click Invitation")
  end

  # POST /invitations
  def create
    @invitation = Invitation.new(invitation_params)
  	@invitation.user_id = params[:user_id]
    @user = User.find(params[:user_id])

    respond_to do |format|
      if !User.find_by_email(@invitation.email).nil?
        @invitation.errors.add(:email, " is already used to sign up")
      end
      if User.find_by_email(@invitation.email).nil? && @invitation.save
        InviteMailer.invite_friend(@user, @invitation).deliver_now

        #track mixpanel
        @mixpanel_tracker.track(@user.id, "Invite Friend")

        format.html { redirect_to users_path, notice: 'Invitation was successfully sent.' }
      else
        error_msg = "Cannot Send Invitation." + "\n"
        @invitation.errors.full_messages.each do |msg|
          error_msg += "\n" + msg
        end
        flash[:error] = error_msg
        format.html { render :new }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:email)
    end
end
