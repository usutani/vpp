class License < ActiveRecord::Base
  belongs_to :user, primary_key: "user_id"
  belongs_to :content, foreign_key: "adam_id", primary_key: "adam_id"
end
