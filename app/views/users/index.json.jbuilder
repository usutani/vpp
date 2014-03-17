json.array!(@users) do |user|
  json.extract! user, :id, :client_user_id_str, :email, :its_id_hash, :status, :user_id
  json.url user_url(user, format: :json)
end
