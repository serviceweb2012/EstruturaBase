require 'test_helper'

class SubMenusControllerTest < ActionController::TestCase
  setup do
    @sub_menu = sub_menus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_menus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_menu" do
    assert_difference('SubMenu.count') do
      post :create, :sub_menu => @sub_menu.attributes
    end

    assert_redirected_to sub_menu_path(assigns(:sub_menu))
  end

  test "should show sub_menu" do
    get :show, :id => @sub_menu.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sub_menu.to_param
    assert_response :success
  end

  test "should update sub_menu" do
    put :update, :id => @sub_menu.to_param, :sub_menu => @sub_menu.attributes
    assert_redirected_to sub_menu_path(assigns(:sub_menu))
  end

  test "should destroy sub_menu" do
    assert_difference('SubMenu.count', -1) do
      delete :destroy, :id => @sub_menu.to_param
    end

    assert_redirected_to sub_menus_path
  end
end
