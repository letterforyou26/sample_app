class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.account_acctivation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailer.reset_pass")
  end
end
