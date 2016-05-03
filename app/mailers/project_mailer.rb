class ProjectMailer < ApplicationMailer
	def new_project_mail(pilot_email)
		mail(:from => 'info@aerialapplications.co', :to => pilot_email, :subject => "You have a new project!")
	end

	def update_hq()
		mail(:from => 'notice@site.com', :to => 'info@aerialapplications.co', :subject => "New Project was created")
	end
end
