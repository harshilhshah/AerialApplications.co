class SignUpMailer < ApplicationMailer

	def signup_mail(user_email)
		mail(:from => 'info@aerialapplications.co', :to => user_email, :subject => "Thank you for signing up!")
	end
end
