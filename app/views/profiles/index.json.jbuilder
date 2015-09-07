json.array!(@profiles) do |profile|
  json.extract! profile, :id, :display_name, :bio, :image, :user_id, :slug, :website
  json.url profile_url(profile, format: :json)
end
