class License < ActiveRecord::Base
  belongs_to :user, primary_key: "user_id"
  belongs_to :content, foreign_key: "adam_id", primary_key: "adam_id"

  def prepare_content
    return if content.present?
    resp = RestClient.get "http://itunes.apple.com/lookup?country=JP&id=#{adam_id}"
    h = JSON.parse(resp)
    return unless h["resultCount"] == 1
    Content.create(adam_id: adam_id, name: h["results"][0]["trackCensoredName"])
  end
end
