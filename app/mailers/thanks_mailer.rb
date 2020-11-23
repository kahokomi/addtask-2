class ThanksMailer < ApplicationMailer
  def user_thanks_mail(user)
    @user = user
    mail(:subject => "登録完了のお知らせ", to: user.email)
  end
end
