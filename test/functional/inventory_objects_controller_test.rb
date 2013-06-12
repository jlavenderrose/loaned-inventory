require 'test_helper'

class InventoryObjectsControllerTest < ActionController::TestCase
  setup do
    @inventory_object = inventory_objects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_object" do
    assert_difference('InventoryObject.count') do
      post :create, inventory_object: { id1: @inventory_object.id1, id2: @inventory_object.id2, id3: @inventory_object.id3 }
    end

    assert_redirected_to inventory_object_path(assigns(:inventory_object))
  end

  test "should show inventory_object" do
    get :show, id: @inventory_object
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_object
    assert_response :success
  end

  test "should update inventory_object" do
    put :update, id: @inventory_object, inventory_object: { id1: @inventory_object.id1, id2: @inventory_object.id2, id3: @inventory_object.id3 }
    assert_redirected_to inventory_object_path(assigns(:inventory_object))
  end

  test "should destroy inventory_object" do
    assert_difference('InventoryObject.count', -1) do
      delete :destroy, id: @inventory_object
    end

    assert_redirected_to inventory_objects_path
  end
end
