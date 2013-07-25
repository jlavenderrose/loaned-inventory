require 'test_helper'

class InventoryLoansControllerTest < ActionController::TestCase

  setup do
    @inventory_loan = inventory_loans(:one)
    session[:user_token] = administrators(:one).remember_token
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_loans)
    
    assert_select "[href$=?open=true]"
  end
  
  test "should get open loan index" do
	get :index, :open => "true"
	
	assert_response :success
	refute_includes assigns(:inventory_loans), inventory_loans(:one)
  end
  
  test "should get open loan index csv" do
	get :index, {:open => "true", :format => "csv" }
	
	assert_response :success
	refute_includes assigns(:inventory_loans), inventory_loans(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_loan" do
    assert_difference('InventoryLoan.count') do
      post :create, inventory_loan: { loaned_date: @inventory_loan.loaned_date,
									  returned_date: Date.today,
									  loanee_id: loanees(:one).id,
									  inventory_object_id: inventory_objects(:two).id }
    end

    assert_redirected_to inventory_loan_path(assigns(:inventory_loan))
  end
  
  test "should create inventory_loan redirect to object" do
	assert_difference('InventoryLoan.count') do
      post :create, inventory_loan: { loaned_date: @inventory_loan.loaned_date,
									  returned_date: Date.today,
									  loanee_token: loanees(:one).id,
									  inventory_object_id: inventory_objects(:two).id },
				    loanee: true
	end
	
	assert_redirected_to inventory_object_path(assigns(:inventory_loan).inventory_object)
  end
  
  test "should create inventory_loan redirect to loanee" do
	assert_difference('InventoryLoan.count') do
      post :create, inventory_loan: { loaned_date: @inventory_loan.loaned_date,
									  returned_date: Date.today,
									  loanee_id: loanees(:one).id,
									  inventory_object_token: inventory_objects(:two).id }
	end
	
	assert_redirected_to loanee_path(assigns(:inventory_loan).loanee)
  end

  test "should show inventory_loan" do
    get :show, id: @inventory_loan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_loan
    assert_response :success
  end

  test "should update inventory_loan" do
    put :update, id: @inventory_loan, inventory_loan: { loaned_date: @inventory_loan.loaned_date, returned_date: @inventory_loan.returned_date }
    assert_redirected_to inventory_loan_path(assigns(:inventory_loan))
  end

  test "should destroy inventory_loan" do
    #assert_difference('InventoryLoan.count', -1) do
      #delete :destroy, id: @inventory_loan
    #end
    delete :destroy, id: @inventory_loan
    assert_equal(assigns(:inventory_loan).returned_date, Date.today)

    assert_redirected_to inventory_loans_path
  end
  
  test "should get import" do
	get :import
	assert_response :success
  end
  
  test "should do import" do
	inventory_loans_import_test = fixture_file_upload('inventory_loans_import_test.csv', 'text/csv')
	
	assert_difference "InventoryLoan.count" do
		post :upload, :csv => inventory_loans_import_test
	end
	
	assert_response :success
  end
end
