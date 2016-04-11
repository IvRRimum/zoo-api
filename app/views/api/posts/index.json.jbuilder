json.array!(@posts) do |post|
  json.extract! post, :id
  json.extract! post, :title
  json.extract! post, :body
  json.note_count post.notes.count
  json.delete_url api_post_url(post, format: :json)
  json.author post.user.email
end
