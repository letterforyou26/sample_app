class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t(".mailer.account_acctivation")
  end

  def password_reset user
    @greeting = t ".mailer.hi"
    mail to: user.email, subject: t(".mailer.reset")
  end
end
