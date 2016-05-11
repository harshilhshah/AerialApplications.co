class Message < ActiveRecord::Base

	def get_sender_name
		return User.find(self.fromId).name
	end
end
