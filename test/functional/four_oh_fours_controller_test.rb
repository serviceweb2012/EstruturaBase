require 'test_helper'

class FourOhFoursControllerTest < ActionController::TestCase
  setup do
    @four_oh_four = four_oh_fours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:four_oh_fours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create four_oh_four" do
    assert_difference('FourOhFour.count') do
      post :create, :four_oh_four => @four_oh_four.attributes
    end

    assert_redirected_to four_oh_four_path(assigns(:four_oh_four))
  end

  test "should show four_oh_four" do
    get :show, :id => @four_oh_four.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @four_oh_four.to_param
    assert_response :success
  end

  test "should update four_oh_four" do
    put :update, :id => @four_oh_four.to_param, :four_oh_four => @four_oh_four.attributes
    assert_redirected_to four_oh_four_path(assigns(:four_oh_four))
  end

  test "should destroy four_oh_four" do
    assert_difference('FourOhFour.count', -1) do
      delete :destroy, :id => @four_oh_four.to_param
    end

    assert_redirected_to four_oh_fours_path
  end
end
