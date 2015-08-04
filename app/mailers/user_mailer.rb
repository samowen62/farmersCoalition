class UserMailer < ActionMailer::Base
  default from: "administrator@fmmetrics.com"

  def password_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
