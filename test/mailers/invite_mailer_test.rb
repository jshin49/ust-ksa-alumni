require 'test_helper'

class InviteMailerTest < ActionMailer::TestCase
  test "invite_friend" do
    mail = InviteMailer.invite_friend
    assert_equal "Invite friend", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
