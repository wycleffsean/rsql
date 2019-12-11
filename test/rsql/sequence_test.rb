require "test_helper"

module Rsql
  class SequenceTest < Minitest::Test
    def test_next!
      sequence = Sequence.new
      assert_equal sequence.next!, 1
      assert_equal sequence.next!, 2
      assert_equal sequence.next!, 3
    end
  end
end
