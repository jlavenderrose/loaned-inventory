require 'test_helper'

class InventoryObjectVersionsControllerTest < ActionController::TestCase
  setup do
    @inventory_object_version = inventory_object_versions(:one)
    session[:user_token] = administrators(:one).remember_token
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_object_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_object_version" do
    assert_difference('InventoryObjectVersion.count') do
      post :create, inventory_object_version: { name: @inventory_object_version.name+"B",
												inventory_object_type_id: inventory_object_types(:one).id}
    end

    assert_redirected_to inventory_object_version_path(assigns(:inventory_object_version))
  end

  test "should show inventory_object_version" do
    get :show, id: @inventory_object_version
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_object_version
    assert_response :success
  end

  test "should update inventory_object_version" do
    put :update, id: @inventory_object_version, inventory_object_version: { name: @inventory_object_version.name }
    assert_redirected_to inventory_object_version_path(assigns(:inventory_object_version))
  end

  test "should destroy inventory_object_version" do
    assert_difference('InventoryObjectVersion.count', -1) do
      delete :destroy, id: @inventory_object_version
    end

    assert_redirected_to inventory_object_versions_path
  end
end
