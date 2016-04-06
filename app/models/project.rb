class Project < ActiveRecord::Base

	def is_active?
		return self.projectTypeId == ProjectType.find_by_description("Active").id
	end

	def is_delivered?
		return self.projectTypeId == ProjectType.find_by_description("Delivered").id
	end
	
	def get_owner_name()
		return User.find(self.owner).name
	end

	def get_client_name()
		return User.find(self.customerId).name
	end

	def get_pilot_name()
		return User.find(self.affiliateId).name
	end
end
