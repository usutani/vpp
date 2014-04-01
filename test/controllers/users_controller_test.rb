require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    Vpp::Application.config.vpp_client.stubs(:register_user)
    assert_difference('User.count') do
      post :create, user: { email: "baz@example.com" }
    end

    assert_redirected_to users_path()
  end

  test "create user error" do
    Vpp::Application.config.vpp_client.stubs(:register_user).raises(AppleVPP::Error::Code9603)
    User.stubs(:create).raises(AppleVPP::Error::Code9603) do
      post :create, user: { email: "baz@example.com" }
    end

    assert_response :success
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    Vpp::Application.config.vpp_client.stubs(:edit_user)
    patch :update, id: @user, user: { client_user_id_str: @user.client_user_id_str, email: @user.email, its_id_hash: @user.its_id_hash, status: @user.status, user_id: @user.user_id }
    assert_redirected_to users_path()
  end

  test "update user error" do
    Vpp::Application.config.vpp_client.stubs(:edit_user).raises(AppleVPP::Error::Code9603)
    User.stubs(:create).raises(AppleVPP::Error::Code9603) do
      patch :update, id: @user, user: { client_user_id_str: @user.client_user_id_str, email: @user.email, its_id_hash: @user.its_id_hash, status: @user.status, user_id: @user.user_id }
    end

    assert_response :success
  end

  test "should destroy user" do
    Vpp::Application.config.vpp_client.stubs(:retire_user)
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
