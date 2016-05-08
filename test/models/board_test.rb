require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test "title_with_user" do
    assert_equal "\"User1's 1st board\" by User1 TrunkTerest", boards(:user1_1).title_with_user
  end
end
