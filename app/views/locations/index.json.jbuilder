json.array!(@locations) do |location|
  json.extract! location, :id, :finder_id, :target_id, :target_x, :target_y, :target_z, :code
  json.url locations_url(location, format: :json)
end
