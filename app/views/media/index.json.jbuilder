json.array!(@media) do |medium|
  json.extract! medium, :id, :projectId, :title, :description, :filepath, :filetype, :mediaTypeId
  json.url medium_url(medium, format: :json)
end
