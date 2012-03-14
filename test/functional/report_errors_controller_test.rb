require 'test_helper'

class ReportErrorsControllerTest < ActionController::TestCase
  setup do
    @report_error = report_errors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_errors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_error" do
    assert_difference('ReportError.count') do
      post :create, :report_error => @report_error.attributes
    end

    assert_redirected_to report_error_path(assigns(:report_error))
  end

  test "should show report_error" do
    get :show, :id => @report_error.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @report_error.to_param
    assert_response :success
  end

  test "should update report_error" do
    put :update, :id => @report_error.to_param, :report_error => @report_error.attributes
    assert_redirected_to report_error_path(assigns(:report_error))
  end

  test "should destroy report_error" do
    assert_difference('ReportError.count', -1) do
      delete :destroy, :id => @report_error.to_param
    end

    assert_redirected_to report_errors_path
  end
end
