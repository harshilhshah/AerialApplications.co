json.array!(@projects) do |project|
  json.extract! project, :id, :customerId, :affiliateId, :address, :zip, :latitude, :longitude, :due, :projectTypeId, :owner
  json.url project_url(project, format: :json)
end
