json.array!(@trip_invitations) do |trip_invitation|
  json.extract! trip_invitation, 
  json.url trip_invitation_url(trip_invitation, format: :json)
end
