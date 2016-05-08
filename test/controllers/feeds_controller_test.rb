require 'test_helper'

class FeedsControllerTest < ActionController::TestCase

  setup do
    sign_in_as :admin
  end

  teardown do
    sign_out_if_logged_in
  end

  test "should get home" do
    get :home
    assert_response :success
  end

end
