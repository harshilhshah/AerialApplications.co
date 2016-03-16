json.array!(@users) do |user|
  json.extract! user, :id, :firstName, :lastName, :zipCode, :email, :username, :password_enc, :password, :salt, :userTypeId, :active, :approved
  json.url user_url(user, format: :json)
end
