require 'rest-client'

class UserMailer < ActionMailer::Base
  default from: "administrator@fmmetrics.com"

  def password_email(email)
  	user = User.where(email: email).first
  	unless user.nil?
  		hash = (0...8).map { (65 + rand(26)).chr }.join
  		u = User.where(email: email)[0]
  		u.reset_hash = hash
  		u.save

	  	RestClient.post "https://api:key-408f273d54022a70dbcc75d1674174bb"\
		"@api.mailgun.net/v3/sandbox18c79c8c9ac64ebbb8e5508deb3d06a4.mailgun.org/messages",
		:from => "FM Metrics <postmaster@sandbox18c79c8c9ac64ebbb8e5508deb3d06a4.mailgun.org>",
		:to => "Sam <#{email}>",
		:subject => "Hello Sam",
		:text => "Reset your password to FM Metrics here: http://fmmetrics.org/reset/#{hash}"
    end
  end
end
