require 'test_helper'

class PointOfSaleControllerTest < ActionController::TestCase
	setup do
		@inventory_object = inventory_objects(:one)
		session[:user_token] = administrators(:one).remember_token
	end

	test "should get create" do
		get :create
		assert_response :success
		assert_template 'point_of_sale/create'
	end
	
	test "should do create" do
		assert_difference "InventoryObject.count" do
		post :create, :inventory_object => { :inventory_object_version_id => @inventory_object.inventory_object_version.id,
											 id1: "a",
											 id2: "a",
											 id3: "a" },
					  :pos_session => {id2: "1", id3: "1"}	 
		end
										
		assert_response :success
		assert_select "#inventory_object_id1[value='a']", 0
		assert_select "#inventory_object_id2[value='a']", 0
		assert_select "#inventory_object_id3[value='a']", 0
	end

	test "should get tag" do
		get :tag
		assert_response :success		
		assert_template 'point_of_sale/tag'
	end

	test "should get lookup" do
		get :lookup
		assert_response :success
		assert_template 'point_of_sale/lookup'
	end
end
