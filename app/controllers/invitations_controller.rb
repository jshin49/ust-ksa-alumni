class InvitationsController < ApplicationController
    before_action :authenticate_user!, only: [:new]

   # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # POST /invitations
  def create
    @invitation = Invitation.new(invitation_params)
  	@invitation.user_id = params[:user_id]
    @user = User.find(params[:user_id])
    
    respond_to do |format|
      if User.find_by_email(@invitation.email).nil? && @invitation.save      
        InviteMailer.invite_friend(@user, @invitation).deliver_now
        format.html { redirect_to users_path, notice: 'Invitation was successfully sent.' }
      else
        flash[:error] = "Cannot Send Invitation"
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
