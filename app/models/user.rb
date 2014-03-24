class User < ActiveRecord::Base
  has_many :licenses, primary_key: "user_id"
  validates :client_user_id_str, uniqueness: true
  validates :email, email_format: {message: ' メールアドレスの形式が不適切です'}

  def can_invite?
    status == "Registered"
  end
end
