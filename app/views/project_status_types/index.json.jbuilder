json.array!(@project_status_types) do |project_status_type|
  json.extract! project_status_type, :id, :description, :name
  json.url project_status_type_url(project_status_type, format: :json)
end
