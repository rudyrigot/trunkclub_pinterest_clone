require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get home" do
    get :home
    assert_response :success
  end

end
