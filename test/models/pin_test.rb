require 'test_helper'

class PinTest < ActiveSupport::TestCase
  test "can_be_edited_by?" do
    assert pins(:user1_1_1).can_be_edited_by?(users(:user1))
    assert pins(:user1_1_1).can_be_edited_by?(users(:admin))
    assert_not pins(:user1_1_1).can_be_edited_by?(users(:user2))
  end
end
