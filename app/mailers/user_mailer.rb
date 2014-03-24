class UserMailer < ActionMailer::Base
  default from: "vpp.sender@gmail.com"

  def invite(user)
    @invite_url = user.invite_url
    mail to: user.email
  end
end
