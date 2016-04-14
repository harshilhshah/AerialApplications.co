class AdminMailer < ApplicationMailer
	default :from => 'from@example.com'

	def contact_mail(name, user_email, message)
		@message = message
		Rails.logger.debug "Email: #{user_email}"
		mail(:from => user_email, :to => ENV['CONTACT_EMAIL'], :subject => "Message from #{name}")
	end
end
