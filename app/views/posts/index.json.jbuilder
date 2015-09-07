json.array!(@posts) do |post|
  json.extract! post, :id, :url, :title, :image, :thumbnail, :embed_code, :description, :author, :author_url, :provider, :provider_url, :hidden, :featured, :user_id, :views, :slug, :tag_list
  json.url post_url(post, format: :json)
end
