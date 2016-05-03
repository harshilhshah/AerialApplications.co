class SignUpMailer < ApplicationMailer

	def signup_mail(user)
		@user = user
		mail(:from => 'info@aerialapplications.co', :to => user.email, :subject => "Registration Confirmation")
	end
end
