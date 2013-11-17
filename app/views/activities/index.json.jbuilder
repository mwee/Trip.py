json.array!(@activities) do |activity|
  json.extract! activity, :topic
  json.url activity_url(activity, format: :json)
end
