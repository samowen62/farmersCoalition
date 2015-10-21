#require 'rest-client'

class UserMailer < ActionMailer::Base
  default from: "admin@fmmetrics.wisc.edu"


  def password_email(email)
  	@user = User.where(email: email).first
  	unless @user.nil?
  		hash = (0...50).map { (65 + rand(26)).chr }.join
  		@user.reset_hash = hash
  		@user.save!

      #this is really weird and hacky but taking the time to figure out
      #the stupid system rails has in place just isn't worth it
      `cp /var/www/app/mailers/mail.txt /var/www/app/mailers/#{hash}`
      `sed -i "s=%url%=http://fmmetrics.wisc.edu/reset/#{hash}=" /var/www/app/mailers/#{hash}`

      #better be sure email is escaped initially
      #already is but might want to be sure there are no spaces
      `sendmail #{email} < /var/www/app/mailers/#{hash}`
      `rm /var/www/app/mailers/#{hash}`

      #mail(to: email, subject: "fmmetrics.wisc Reset password")

=begin
	  	RestClient.post "https://api:key-408f273d54022a70dbcc75d1674174bb"\
		"@api.mailgun.net/v3/sandbox18c79c8c9ac64ebbb8e5508deb3d06a4.mailgun.org/messages",
		:from => "FM Metrics <postmaster@sandbox18c79c8c9ac64ebbb8e5508deb3d06a4.mailgun.org>",
		:to => "Sam <#{email}>",
		:subject => "Hello Sam",
		:text => "Reset your password to FM Metrics here: http://fmmetrics.org/reset/#{hash}"
=end
    end
  end
end
