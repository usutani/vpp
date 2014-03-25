class UserMailer < ActionMailer::Base
  default from: "vpp.sender@gmail.com"

  def invite(user)
    @invite_url = user.invite_url
    mail to: user.email
  end

  def notify(license)
    @name = license.content.name
    @content_url = license.adam_id
    mail to: license.user.email
  end
end
