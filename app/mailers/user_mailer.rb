class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("users.sbj_acc")
  end

  def password_reset
    @greeting = t("users.hi")

    mail to: "to@example.org"
  end
end
