require 'test_helper'

class LicensesControllerTest < ActionController::TestCase
  setup do
    @license = licenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licenses)
  end

  test "should get new" do
=begin
    get :new
    assert_response :success
=end
  end

  test "should create license" do
=begin
    assert_difference('License.count') do
      post :create, license: { adam_id: @license.adam_id, client_user_id_str: @license.client_user_id_str, is_irrevocable: @license.is_irrevocable, its_id_hash: @license.its_id_hash, license_id: @license.license_id, pricing_param: @license.pricing_param, product_type_id: @license.product_type_id, product_type_name: @license.product_type_name, status: @license.status, user_id: @license.user_id }
    end

    assert_redirected_to license_path(assigns(:license))
=end
  end

  test "should show license" do
    get :show, id: @license
    assert_response :success
  end

  test "should get edit" do
=begin
    get :edit, id: @license
    assert_response :success
=end
  end

  test "should update license" do
=begin
    patch :update, id: @license, license: { adam_id: @license.adam_id, client_user_id_str: @license.client_user_id_str, is_irrevocable: @license.is_irrevocable, its_id_hash: @license.its_id_hash, license_id: @license.license_id, pricing_param: @license.pricing_param, product_type_id: @license.product_type_id, product_type_name: @license.product_type_name, status: @license.status, user_id: @license.user_id }
    assert_redirected_to license_path(assigns(:license))
=end
  end

  test "should destroy license" do
=begin
    assert_difference('License.count', -1) do
      delete :destroy, id: @license
    end

    assert_redirected_to licenses_path
=end
  end
end
