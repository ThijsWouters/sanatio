require 'minitest_helper'

class TestSanatio < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sanatio::VERSION
  end
end
