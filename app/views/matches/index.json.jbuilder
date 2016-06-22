json.array!(@matches) do |match|
  json.extract! match, :id, :finder_id, :target_id, :target_x, :target_y, :target_z, :code
  json.url match_url(match, format: :json)
end
