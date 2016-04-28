class AdminMailer < ApplicationMailer
	default :from => 'from@example.com'

	def contact_mail(name, user_email, message)
		@message = message
		mail(:from => user_email, :to => ENV['CONTACT_EMAIL'], :subject => "Message from #{name}")
	end
	
end
