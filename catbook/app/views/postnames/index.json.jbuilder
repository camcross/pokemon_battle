json.array!(@postnames) do |postname|
  json.extract! postname, :id, :name, :body
  json.url postname_url(postname, format: :json)
end
