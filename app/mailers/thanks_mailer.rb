class ThanksMailer < ApplicationMailer
  def user_thanks_mail(user)
    @user = user
    mail to: user.email, subject:"新規登録完了のご連絡" do |format|
      format.text
    end
  end
end
