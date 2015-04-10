require 'minitest_helper'

class TestUsageErrors < Minitest::Test
  def test_no_block_given_with_a_field_validation
    usage_error = assert_raises(Sanatio::UsageError) do
      Class.new do
        include Sanatio

        ensure_that(:field).is.reason = :not_nil
      end
    end

    assert_equal("You need to give a block to #is.", usage_error.message)
  end

  def test_no_block_given_with_a_class_validation
    usage_error = assert_raises(Sanatio::UsageError) do
      Class.new do
        include Sanatio

        ensure_that(self).is.reason = :not_nil
      end
    end

    assert_equal("You need to give a block to #is.", usage_error.message)
  end
end
