require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @user = users(:user1)
  end

  teardown do
    sign_out_if_logged_in
  end

  test "should get index" do
    sign_in_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
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

  test "should not get new if not admin" do
    sign_in_as :user1
    get :new
    assert_redirected_to root_path
  end

  test "should create user" do
    sign_in_as :admin
    assert_difference('User.count') do
      post :create, user: { admin: @user.admin, email: 'foo@mail.com', first_name: @user.first_name, last_name: @user.last_name, password: 'FooBar' }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should not create user if not admin" do
    sign_in_as :user1
    assert_difference('User.count', 0) do
      post :create, user: { admin: @user.admin, email: 'foo@mail.com', first_name: @user.first_name, last_name: @user.last_name, password: 'FooBar' }
    end

    assert_redirected_to root_path
  end

  test "should show user" do
    sign_in_as :admin
    get :show, id: @user
    assert_response :success
  end

  test "should show user even if not admin" do
    sign_in_as :user2
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    sign_in_as :admin
    get :edit, id: @user
    assert_response :success
  end

  test "should not get edit if not admin" do
    sign_in_as :user1
    get :edit, id: @user
    assert_redirected_to root_path
  end

  test "should update user" do
    sign_in_as :admin
    patch :update, id: @user, user: { admin: @user.admin, email: @user.email, first_name: @user.first_name, last_name: @user.last_name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not update user if not admin" do
    sign_in_as :user1
    patch :update, id: @user, user: { admin: @user.admin, email: @user.email, first_name: @user.first_name, last_name: @user.last_name }
    assert_redirected_to root_path
  end

  test "should destroy user" do
    sign_in_as :admin
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "should not destroy user if not admin" do
    sign_in_as :user1
    assert_difference('User.count', 0) do
      delete :destroy, id: @user
    end
    assert_redirected_to root_path
  end
end
