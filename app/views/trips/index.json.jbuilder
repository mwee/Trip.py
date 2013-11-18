json.array!(@trips) do |trip|
  json.extract! trip, :title, :destination,:description, :link, :start_date, :end_date, :cost_min, :cost_max
  json.url trip_url(trip, format: :json)
end
