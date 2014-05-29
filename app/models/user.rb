# coding: utf-8
class User < ActiveRecord::Base
  has_many :licenses, primary_key: "user_id"
  validates :client_user_id_str, uniqueness: true
  validates :email, email_format: {message: ' メールアドレスの形式が不適切です'}
  validates :email, presence: true, uniqueness: true

  enum status: [:registered, :associated, :retired, :deleted]

  before_create do
    self.client_user_id_str ||= SecureRandom.uuid
  end

  after_create do
    h = { client_user_id_str: self.client_user_id_str, email: self.email }
    Vpp::Application.config.vpp_client.register_user(h)
    #binding.pry
    #raise Exception.new("CRASH")
  end

  after_update do
    h = { client_user_id_str: self.client_user_id_str, email: self.email }
    Vpp::Application.config.vpp_client.edit_user(h)
  end

  after_destroy do
    h = { client_user_id_str: self.client_user_id_str }
    Vpp::Application.config.vpp_client.retire_user(h)
  end

  def can_invite?
    registered?
  end
end
