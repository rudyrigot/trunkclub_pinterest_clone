require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test "title_with_user" do
    assert_equal "\"User1's 1st board\" by User1 TrunkTerest", boards(:user1_1).title_with_user
  end

  test "can_be_edited_by?" do
    board = boards(:user1_1)
    assert board.can_be_edited_by?(users(:user1))
    assert board.can_be_edited_by?(users(:admin))
    assert board.can_be_edited_by?(users(:rudy))
    assert_not board.can_be_edited_by?(users(:user2))
  end
end
