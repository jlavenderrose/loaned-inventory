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
