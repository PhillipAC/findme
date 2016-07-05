json.array!(@profiles) do |profile|
  json.extract! profile, :id, :location, :birth_day, :about
  json.url profile_url(profile, format: :json)
end
