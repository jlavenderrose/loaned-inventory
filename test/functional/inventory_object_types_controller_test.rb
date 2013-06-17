require 'test_helper'

class InventoryObjectTypesControllerTest < ActionController::TestCase
  setup do
    @inventory_object_type = inventory_object_types(:one)
    session[:user_token] = administrators(:one).remember_token
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_object_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_object_type" do
    assert_difference('InventoryObjectType.count') do
      post :create, inventory_object_type: { name: @inventory_object_type.name }
    end

    assert_redirected_to inventory_object_type_path(assigns(:inventory_object_type))
  end

  test "should show inventory_object_type" do
    get :show, id: @inventory_object_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_object_type
    assert_response :success
  end

  test "should update inventory_object_type" do
    put :update, id: @inventory_object_type, inventory_object_type: { name: @inventory_object_type.name }
    assert_redirected_to inventory_object_type_path(assigns(:inventory_object_type))
  end

  test "should destroy inventory_object_type" do
    assert_difference('InventoryObjectType.count', -1) do
      delete :destroy, id: @inventory_object_type
    end

    assert_redirected_to inventory_object_types_path
  end
end
