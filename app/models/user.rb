class User < ActiveRecord::Base
  validates :client_user_id_str, :user_id, uniqueness: true
end
