require 'test_helper'

class AuditLogEntriesControllerTest < ActionController::TestCase
  def setup
    session[:user_token] = administrators(:one).remember_token
  end
  
  setup do
    @audit_log_entry = audit_log_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:audit_log_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create audit_log_entry" do
    assert_difference('AuditLogEntry.count') do
      post :create, audit_log_entry: { desc: @audit_log_entry.desc }
    end

    assert_redirected_to audit_log_entry_path(assigns(:audit_log_entry))
  end

  test "should show audit_log_entry" do
    get :show, id: @audit_log_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @audit_log_entry
    assert_response :success
  end

  test "should update audit_log_entry" do
    put :update, id: @audit_log_entry, audit_log_entry: { desc: @audit_log_entry.desc }
    assert_redirected_to audit_log_entry_path(assigns(:audit_log_entry))
  end

  test "should destroy audit_log_entry" do
    assert_difference('AuditLogEntry.count', -1) do
      delete :destroy, id: @audit_log_entry
    end

    assert_redirected_to audit_log_entries_path
  end
end
