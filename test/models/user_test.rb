require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "email uniqueness" do
    u = User.new(email: @user.email)
    assert u.invalid?
    assert u.errors[:email].any?
  end
end
