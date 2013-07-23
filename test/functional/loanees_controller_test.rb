require 'test_helper'

class LoaneesControllerTest < ActionController::TestCase
  setup do
    @loanee = loanees(:one)
    session[:user_token] = administrators(:one).remember_token
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loanees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loanee" do
    assert_difference('Loanee.count') do
      post :create, loanee: { fullname: @loanee.fullname, idnum: @loanee.idnum }
    end

    assert_redirected_to loanee_path(assigns(:loanee))
  end

  test "should show loanee" do
    get :show, id: @loanee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loanee
    assert_response :success
  end

  test "should update loanee" do
    put :update, id: @loanee, loanee: { fullname: @loanee.fullname, idnum: @loanee.idnum }
    assert_redirected_to loanee_path(assigns(:loanee))
  end

  test "should destroy loanee" do
    assert_difference('Loanee.count', -1) do
      delete :destroy, id: @loanee
    end

    assert_redirected_to loanees_path
  end
  
  test "should get import" do
	get :import
	assert_response :success
  end
  
  test "should do import" do
	loanee_import_test = fixture_file_upload('loanee_import_test.csv', 'text/csv')
	
	assert_difference "Loanee.count" do
		post :upload, :csv => loanee_import_test
	end
	
	assert_response :success
  end
end
