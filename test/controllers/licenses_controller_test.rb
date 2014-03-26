require 'test_helper'

class LicensesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @license = licenses(:one)
  end

  test "should sync licenses" do
    h = { licenses: Array.new }
    Vpp::Application.config.vpp_client.stubs(:get_licenses).returns(h)
    get :sync
  end

  test "should associate license with user" do
    h = { user_id: @user.user_id, license_id: @license.license_id }
    Vpp::Application.config.vpp_client.expects(:associate_license_with_user).with(h)
    get :associate, id: @license, user_id: @user
  end

  test "should disassociate license from user" do
    h = { license_id: @license.license_id }
    Vpp::Application.config.vpp_client.expects(:disassociate_license_from_user).with(h)
    get :disassociate, id: @license
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licenses)
  end

  test "should show license" do
    get :show, id: @license
    assert_response :success
  end
end
