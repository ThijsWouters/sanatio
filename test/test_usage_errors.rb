require 'minitest_helper'

class TestUsageErrors < Minitest::Test
  def test_is_missing_block
    usage_error = assert_raises(Sanatio::UsageError) do
      Class.new do
        include Sanatio

        ensure_that(:field).is.reason = :not_nil
      end
    end

    assert_equal("You need to give a block to #is.", usage_error.message)
  end

  def test_skip_if_missing_block
    usage_error = assert_raises(Sanatio::UsageError) do
      Class.new do
        include Sanatio

        ensure_that(self).is { true }.skip_if.reason = :not_nil
      end
    end

    assert_equal("You need to give a block to #skip_if.", usage_error.message)
  end
end
