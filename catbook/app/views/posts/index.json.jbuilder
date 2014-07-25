json.array!(@posts) do |post|
  json.extract! post, :id, :handle, :body
  json.url post_url(post, format: :json)
end
