require 'test_helper'

class InventoryObjectsControllerTest < ActionController::TestCase
  setup do
    @inventory_object = inventory_objects(:one)
    session[:user_token] = administrators(:one).remember_token
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_objects)
    
    assert_select "#search_idnum"
    assert_select "#search_tags"
    assert_select "#search_versionid"
    assert_select "#search_typeid"
  end
  
  test "get index w/ type search" do
	get :index, :search => { typeid: inventory_object_types(:two).id } 
	
	other_type = InventoryObjectType.find(inventory_object_types(:one).id)
	
	assert_response :success
	refute_includes assigns(:inventory_objects), other_type.inventory_objects.first
  end
  
  test "get index w/ all search" do
	get :index, :search => { versionid: 0, typeid: 0 }
	
	assert_response :success
	assert_includes assigns(:inventory_objects), InventoryObject.last
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_object" do
    assert_difference('InventoryObject.count') do
      post :create, inventory_object: { id1: @inventory_object.id1+"B", 
										id2: @inventory_object.id2+"B", 
										id3: @inventory_object.id3+"B",
										inventory_object_version_id: inventory_object_versions(:one) }
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

  test "should update inventory_object status_tags_list" do
	assert_difference('@inventory_object.audit_log_entries.count') do
  		put :update, id: @inventory_object, inventory_object: {status_tag_list: "a, b, c"}
		assert_redirected_to inventory_object_path(assigns(:inventory_object))
	end
  end

  test "should destroy inventory_object" do
    assert_difference('InventoryObject.count', -1) do
      delete :destroy, id: @inventory_object
    end

    assert_redirected_to inventory_objects_path
  end
  
  test "should get import" do
	get :import
	assert_response :success
  end
  
  test "should do import" do
	inventory_object_import_test = fixture_file_upload('inventory_object_import_test.csv', 'text/csv')
	
	assert_difference "InventoryObject.count" do
	assert_difference "InventoryObjectVersion.count" do
	assert_difference "InventoryObjectType.count" do
	post :upload, :csv => inventory_object_import_test
	end
	end
	end
	
	assert_response :success
  end
end
