require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'admin?' do
    assert users(:admin).admin?
    assert users(:rudy).admin?
    assert_not users(:user1).admin?
  end

  test 'full_name' do
    assert_equal 'User1 TrunkTerest', users(:user1).full_name
    users(:user1).first_name = nil
    assert_equal 'user1@gmail.com', users(:user1).full_name
  end
end
