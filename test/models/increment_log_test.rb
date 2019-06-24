require 'test_helper'

class IncrementLogTest < ActiveSupport::TestCase

  test "should return nil for a user that don't have a increment added yet" do
    lastNumber = IncrementLog.selectLast(55);
    assert_not lastNumber, "Should return nil"
  end

  test "should return the last number inserted for a user" do 
    lastNumber = IncrementLog.selectLast(increment_logs(:one).user_id);
    assert lastNumber, "Should return a object"
  end
end
