json.array!(@interactions) do |interaction|
  json.extract! interaction, :id, :user, :url, :type
  json.url interaction_url(interaction, format: :json)
end
