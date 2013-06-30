require 'test_helper'

class AdministratorsControllerTest < ActionController::TestCase
  def setup
    session[:user_token] = administrators(:one).remember_token
  end

  setup do
    @administrator = administrators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administrators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrator" do
    assert_difference('Administrator.count') do
      post :create, administrator: { username: @administrator.username+"B",
									 fullname: @administrator.fullname+"B",
									 password: "B",
									 password_confirmation: "B"}
    end

    assert_redirected_to administrator_path(assigns(:administrator))
  end

  test "should show administrator" do
    get :show, id: @administrator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrator
    assert_response :success
  end

  test "should update administrator" do
    put :update, id: @administrator, administrator: { fullname: @administrator.fullname,
													  password: 'b',
													  password_confirmation: 'b'}
    assert_redirected_to administrator_path(assigns(:administrator))
  end

  test "should destroy administrator" do
    assert_difference('Administrator.count', -1) do
      delete :destroy, id: @administrator
    end

    assert_redirected_to administrators_path
  end
end
