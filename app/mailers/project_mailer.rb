class ProjectMailer < ApplicationMailer
	def new_project_mail(pilot_email)
		mail(:from => 'info@aerialapplications.co', :to => pilot_email, :subject => "You have been selected for a project, confirm availability")
	end

	def order_placed_mail(client_email)
		mail(:from => 'info@aerialapplications.co', :to => client_email, :subject => "Your order has been received")
	end

	def client_notify_payment_received(client_email)
		mail(:from => 'info@aerialapplications.co', :to => client_email, :subject => "Your payment has been recieved")
	end

	def upcoming_project_mail(pilot_email)
		mail(:from => 'info@aerialapplications.co', :to => pilot_email, :subject => "Your upcoming project")
	end

	def pilot_alert_payment_received(pilot_email)
		mail(:from => 'info@aerialapplications.co', :to => pilot_email, :subject => "Payment received")
	end

	def remind_pilot(pilot_email)
		mail(:from => 'info@aerialapplications.co', :to => pilot_email, :subject => "Confirm project completion and upload files")
	end

	def update_hq()
		mail(:from => 'notice@site.com', :to => 'info@aerialapplications.co', :subject => "New Order placed")
	end

	def sales_alert_payment_received()
		mail(:from => 'notice@site.com', :to => 'info@aerialapplications.co', :subject => "Payment received")
	end
end
