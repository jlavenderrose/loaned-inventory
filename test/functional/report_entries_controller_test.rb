require 'test_helper'

class ReportEntriesControllerTest < ActionController::TestCase
  setup do
    @report_entry = report_entries(:one)
    session[:user_token] = administrators(:one).remember_token
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_entry" do
    assert_difference('ReportEntry.count') do
      post :create, report_entry: { body: @report_entry.body, 
									administrator_id: administrators(:one),
									inventory_object_tokens: inventory_objects(:one).id }
    end

	#redirects to object if only a single object is associated
    assert_redirected_to inventory_object_path(assigns(:report_entry).inventory_objects.first)
  end
  
  #TODO: should create report_entry with multiple associated inventory objects

  test "should show report_entry" do
    get :show, id: @report_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report_entry
    assert_response :success
  end

  test "should update report_entry" do
    put :update, id: @report_entry, report_entry: { body: @report_entry.body }
    assert_redirected_to report_entry_path(assigns(:report_entry))
  end

  test "should destroy report_entry" do
    assert_difference('ReportEntry.count', -1) do
      delete :destroy, id: @report_entry
    end

    assert_redirected_to report_entries_path
  end
end
