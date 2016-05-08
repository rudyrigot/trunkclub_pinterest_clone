require 'test_helper'

class PinsControllerTest < ActionController::TestCase

  setup do
    @pin = pins(:user1_1_1)
  end

  teardown do
    sign_out_if_logged_in
  end

  test "should get index" do
    sign_in_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:pins)
  end

  test "should not get index if not admin" do
    sign_in_as :user1
    get :index
    assert_redirected_to root_path
  end

  test "should get new" do
    sign_in_as :admin
    get :new
    assert_response :success
  end

  test "everyone should get new" do
    sign_in_as :user2
    get :new
    assert_response :success
  end

  test "should create pin" do
    sign_in_as :admin
    assert_difference('Pin.count') do
      post :create, pin: { board_id: @pin.board_id, description: @pin.description, link: @pin.link, title: @pin.title }
    end

    assert_redirected_to pin_path(assigns(:pin))
  end

  test "everyone should create pin" do
    sign_in_as :user2
    assert_difference('Pin.count') do
      post :create, pin: { board_id: @pin.board_id, description: @pin.description, link: @pin.link, title: @pin.title }
    end

    assert_redirected_to pin_path(assigns(:pin))
  end

  test "should show pin" do
    sign_in_as :admin
    get :show, id: @pin
    assert_response :success
  end

  test "everyone should show pin" do
    sign_in_as :user2
    get :show, id: @pin
    assert_response :success
  end

  test "admin should get edit" do
    sign_in_as :admin
    get :edit, id: @pin
    assert_response :success
  end

  test "owner should get edit" do
    sign_in_as :user1
    get :edit, id: @pin
    assert_response :success
  end

  test "everyone should not get edit" do
    sign_in_as :user2
    get :edit, id: @pin
    assert_redirected_to root_path
  end

  test "admin should update pin" do
    sign_in_as :admin
    patch :update, id: @pin, pin: { board_id: @pin.board_id, description: @pin.description, link: @pin.link, title: @pin.title }
    assert_redirected_to pin_path(assigns(:pin))
  end

  test "owner should update pin" do
    sign_in_as :user1
    patch :update, id: @pin, pin: { board_id: @pin.board_id, description: @pin.description, link: @pin.link, title: @pin.title }
    assert_redirected_to pin_path(assigns(:pin))
  end

  test "everyone should update pin" do
    sign_in_as :user2
    patch :update, id: @pin, pin: { board_id: @pin.board_id, description: @pin.description, link: @pin.link, title: @pin.title }
    assert_redirected_to root_path
  end

  test "admin should destroy pin" do
    sign_in_as :admin
    assert_difference('Pin.count', -1) do
      delete :destroy, id: @pin
    end

    assert_redirected_to pins_path
  end

  test "owner should destroy pin" do
    sign_in_as :user1
    assert_difference('Pin.count', -1) do
      delete :destroy, id: @pin
    end

    assert_redirected_to pins_path
  end

  test "everyone should destroy pin" do
    sign_in_as :user2
    assert_difference('Pin.count', 0) do
      delete :destroy, id: @pin
    end

    assert_redirected_to root_path
  end
end
