require 'test_helper'

class BuddyGroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buddy_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buddy_group" do
    assert_difference('BuddyGroup.count') do
      post :create, :buddy_group => { }
    end

    assert_redirected_to buddy_group_path(assigns(:buddy_group))
  end

  test "should show buddy_group" do
    get :show, :id => buddy_groups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => buddy_groups(:one).to_param
    assert_response :success
  end

  test "should update buddy_group" do
    put :update, :id => buddy_groups(:one).to_param, :buddy_group => { }
    assert_redirected_to buddy_group_path(assigns(:buddy_group))
  end

  test "should destroy buddy_group" do
    assert_difference('BuddyGroup.count', -1) do
      delete :destroy, :id => buddy_groups(:one).to_param
    end

    assert_redirected_to buddy_groups_path
  end
end
