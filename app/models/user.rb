class User < ActiveRecord::Base
  validates :client_user_id_str, uniqueness: true
end
