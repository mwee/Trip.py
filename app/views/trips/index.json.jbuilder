json.array!(@trips) do |trip|
  json.extract! trip, :title, :destination
  json.url trip_url(trip, format: :json)
end
