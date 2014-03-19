class License < ActiveRecord::Base
  belongs_to :user, primary_key: "user_id"
end
