json.array!(@trips) do |trip|
  json.extract! trip, :title
  json.url trip_url(trip, format: :json)
end
