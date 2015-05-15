class InviteMailer < ActionMailer::Base 

  default from: "pj@ustksa.com"
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.invite_friend.subject
  #
  def invite_friend(user, invitation)
    @user = user
  	@link = get_link_from_invitation
    @invitation = invitation
    
    mail to: @invitation.email, subject: "Invitation to HKUST KSA Alumni Page"
  end
  
  def get_link_from_invitation
    	"http://facebook.com"
  end
end
