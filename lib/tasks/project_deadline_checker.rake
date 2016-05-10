desc "This task is called by the Heroku scheduler add-on"
task :find_overdue_projects => :environment do
  puts "Checking for project deadlines..."
  @projects = Project.where("EXTRACT(DAY FROM due) = ? AND EXTRACT(MONTH FROM due) = ?", 28, Date.today.month)
  @projects.each do |p|
  	pilot_email = User.find(p.affiliateId).email
  	if pilot_email
  		ProjectMailer.remind_pilot(pilot_email).deliver
  	end
  end
  puts "done."
end