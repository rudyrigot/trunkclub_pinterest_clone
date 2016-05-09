require 'test_helper'

class BoardsControllerTest < ActionController::TestCase

  setup do
    @board = boards(:user1_1)
  end

  teardown do
    sign_out_if_logged_in
  end

  test "should get index" do
    sign_in_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:boards)
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

  test "everybody should get new" do
    sign_in_as :user2
    get :new
    assert_response :success
  end

  test "should create board" do
    sign_in_as :admin
    assert_difference('Board.count') do
      post :create, board: { description: @board.description, title: @board.title, user_id: @board.user_id }
    end
    assert_equal users(:user1), assigns(:board).user

    assert_redirected_to board_path(assigns(:board))
  end

  test "everybody should create board" do
    sign_in_as :user1
    assert_difference('Board.count') do
      post :create, board: { description: @board.description, title: @board.title, user_id: @board.user_id }
    end
    assert_equal users(:user1), assigns(:board).user

    assert_redirected_to board_path(assigns(:board))
  end

  test "can only create board for oneself" do
    sign_in_as :user2
    assert_difference('Board.count') do
      post :create, board: { description: @board.description, title: @board.title, user_id: @board.user_id }
    end
    assert_equal users(:user2), assigns(:board).user

    assert_redirected_to board_path(assigns(:board))
  end

  test "should show board" do
    sign_in_as :admin
    get :show, id: @board
    assert_response :success
  end

  test "everybody should show board" do
    sign_in_as :user2
    get :show, id: @board
    assert_response :success
  end

  test "admin should get edit" do
    sign_in_as :admin
    get :edit, id: @board
    assert_response :success
  end

  test "owner should get edit" do
    sign_in_as :user1
    get :edit, id: @board
    assert_response :success
  end

  test "everybody should not get edit" do
    sign_in_as :user2
    get :edit, id: @board
    assert_redirected_to root_path
  end

  test "admin should update board" do
    sign_in_as :admin
    patch :update, id: @board, board: { description: @board.description, title: @board.title, user_id: @board.user_id }
    assert_redirected_to board_path(assigns(:board))
  end

  test "owner should update board" do
    sign_in_as :user1
    patch :update, id: @board, board: { description: @board.description, title: @board.title, user_id: @board.user_id }
    assert_redirected_to board_path(assigns(:board))
  end

  test "everybody should not update board" do
    sign_in_as :user2
    patch :update, id: @board, board: { description: @board.description, title: @board.title, user_id: @board.user_id }
    assert_redirected_to root_path
  end

  test "admin should destroy board" do
    sign_in_as :admin
    assert_difference('Board.count', -1) do
      delete :destroy, id: @board
    end

    assert_redirected_to user_path(users(:user1))
  end

  test "owner should destroy board" do
    sign_in_as :user1
    assert_difference('Board.count', -1) do
      delete :destroy, id: @board
    end

    assert_redirected_to user_path(users(:user1))
  end

  test "everybody should not destroy board" do
    sign_in_as :user2
    assert_difference('Board.count', 0) do
      delete :destroy, id: @board
    end

    assert_redirected_to root_path
  end

  test "everybody but owner should subscribe to board" do
    sign_in_as :user2
    assert_difference "User.find(users(:user2).id).subscriptions.count" do
      assert_difference "Board.find(boards(:user1_1).id).subscribers.count" do
        post :subscribe, id: boards(:user1_1)
      end
    end
    assert_redirected_to board_path(boards(:user1_1))
  end

  test "everybody but owner should subscribe to board in JSON format" do
    sign_in_as :user2
    assert_difference "User.find(users(:user2).id).subscriptions.count" do
      assert_difference "Board.find(boards(:user1_1).id).subscribers.count" do
        post :subscribe, id: boards(:user1_1), format: 'json'
      end
    end
    assert_response :success
    assert_equal 'OK', response.body
  end

  test "owner should not subscribe to own board" do
    sign_in_as :user1
    assert_difference "User.find(users(:user2).id).subscriptions.count", 0 do
      assert_difference "Board.find(boards(:user1_1).id).subscribers.count", 0 do
        post :subscribe, id: boards(:user1_1)
      end
    end
    assert_redirected_to root_path
  end

  test "everybody but owner should unsubscribe to board" do
    users(:user2).update! subscriptions: [boards(:user1_1)]
    sign_in_as :user2
    assert_difference "User.find(users(:user2).id).subscriptions.count", -1 do
      assert_difference "Board.find(boards(:user1_1).id).subscribers.count", -1 do
        post :unsubscribe, id: boards(:user1_1)
      end
    end
    assert_redirected_to board_path(boards(:user1_1))
  end

  test "everybody but owner should unsubscribe to board in JSON format" do
    users(:user2).update! subscriptions: [boards(:user1_1)]
    sign_in_as :user2
    assert_difference "User.find(users(:user2).id).subscriptions.count", -1 do
      assert_difference "Board.find(boards(:user1_1).id).subscribers.count", -1 do
        post :unsubscribe, id: boards(:user1_1), format: 'json'
      end
    end
    assert_response :success
    assert_equal 'OK', response.body
  end

  test "owner should not unsubscribe to own board" do
    sign_in_as :user1
    assert_difference "User.find(users(:user2).id).subscriptions.count", 0 do
      assert_difference "Board.find(boards(:user1_1).id).subscribers.count", 0 do
        post :unsubscribe, id: boards(:user1_1)
      end
    end
    assert_redirected_to root_path
  end
end
