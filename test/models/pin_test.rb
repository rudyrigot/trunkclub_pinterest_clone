require 'test_helper'

class PinTest < ActiveSupport::TestCase
  test "can_be_edited_by?" do
    assert pins(:user1_1_1).can_be_edited_by?(users(:user1))
    assert pins(:user1_1_1).can_be_edited_by?(users(:admin))
    assert_not pins(:user1_1_1).can_be_edited_by?(users(:user2))
  end

  test "most_recent" do
    assert_equal [670927629, 1056234161, 633025876, 1018324200], Pin.most_recent.map(&:id)
  end

  test "most_recent_on_boards" do
    assert_equal [670927629, 1056234161], Pin.most_recent_on_boards([boards(:user1_1)]).map(&:id)
  end
end
