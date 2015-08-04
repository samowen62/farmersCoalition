class UserMailer < ActionMailer::Base
  default from: "administrator@fmmetrics.com"

  def password_email(user)
  	RestClient.post "https://api:key-408f273d54022a70dbcc75d1674174bb"\
	"@api.mailgun.net/v3/sandbox18c79c8c9ac64ebbb8e5508deb3d06a4.mailgun.org/messages",
	:from => "Mailgun Sandbox <postmaster@sandbox18c79c8c9ac64ebbb8e5508deb3d06a4.mailgun.org>",
	:to => "Sam <#{user.email}>",
	:subject => "Hello Sam",
	:text => "Congratulations Sam, you just sent an email with Mailgun!  You are truly awesome! 
	 You can see a record of this email in your logs: https://mailgun.com/cp/log .  
	 You can send up to 300 emails/day from this sandbox server.  
	 Next, you should add your own domain so you can send 10,000 emails/month for free."

	 
    #@user = user
    #@url  = 'http://example.com/login'
    #mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
