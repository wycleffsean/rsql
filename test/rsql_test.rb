require "test_helper"

class RsqlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rsql::VERSION
  end
end
