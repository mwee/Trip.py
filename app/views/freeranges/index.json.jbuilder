json.array!(@freeranges) do |freerange|
  json.extract! freerange, :start_date, :end_date
  json.url freerange_url(freerange, format: :json)
end
