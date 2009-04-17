require 'test_helper'

class BuddiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buddies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buddy" do
    assert_difference('Buddy.count') do
      post :create, :buddy => { }
    end

    assert_redirected_to buddy_path(assigns(:buddy))
  end

  test "should show buddy" do
    get :show, :id => buddies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => buddies(:one).to_param
    assert_response :success
  end

  test "should update buddy" do
    put :update, :id => buddies(:one).to_param, :buddy => { }
    assert_redirected_to buddy_path(assigns(:buddy))
  end

  test "should destroy buddy" do
    assert_difference('Buddy.count', -1) do
      delete :destroy, :id => buddies(:one).to_param
    end

    assert_redirected_to buddies_path
  end
end
