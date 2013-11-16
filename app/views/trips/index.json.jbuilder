json.array!(@trips) do |trip|
  json.extract! trip, :title, :destination, :start_date, :end_date, :budget_in_min, :budget_out_min, :budget_in_max, :budget_out_max
  json.url trip_url(trip, format: :json)
end
