class UserMailer < ApplicationMailer
	def new_card_mail(pilot_email)
		mail(:from => 'info@aerialapplications.co', :to => pilot_email, :subject => "You have added a new payment method!")
	end

	def signup_mail(user)
		@user = user
		mail(:from => 'info@aerialapplications.co', :to => user.email, :subject => "Registration Confirmation")
	end

	def welcome_mail(user)
		@user = user
		mail(:from => 'info@aerialapplications.co', :to => user.email, :subject => "Welcome")
	end
end
