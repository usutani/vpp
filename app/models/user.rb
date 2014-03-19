class User < ActiveRecord::Base
  has_many :licenses, primary_key: "user_id"
  validates :client_user_id_str, uniqueness: true
end
