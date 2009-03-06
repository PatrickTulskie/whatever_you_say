require 'test_helper'

class ChatsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chat" do
    assert_difference('Chat.count') do
      post :create, :chat => { }
    end

    assert_redirected_to chat_path(assigns(:chat))
  end

  test "should show chat" do
    get :show, :id => chats(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => chats(:one).id
    assert_response :success
  end

  test "should update chat" do
    put :update, :id => chats(:one).id, :chat => { }
    assert_redirected_to chat_path(assigns(:chat))
  end

  test "should destroy chat" do
    assert_difference('Chat.count', -1) do
      delete :destroy, :id => chats(:one).id
    end

    assert_redirected_to chats_path
  end
end
