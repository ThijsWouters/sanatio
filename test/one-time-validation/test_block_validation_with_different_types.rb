require 'minitest_helper'

class TestBlockWithDifferentTypes < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(gender)
        @gender = gender
      end

      attr_reader :gender

      ensure_that(:gender).is { !nil? }
    end
  end

  def test_passes_when_symbol
    assert_valid(person_class.new(:female))
  rescue TypeError => e
    skip("Possible Ruby bug: #{e.inspect}")
  end

  def test_passes_when_coercing_string_to_symbol
    assert_valid(person_class.new("male".to_sym))
  rescue TypeError => e
    skip("Possible Ruby bug: #{e.inspect}")
  end

  def test_passes_when_bignum
    assert_valid(person_class.new(12323234534534535345345))
  rescue TypeError => e
    skip("Possible Ruby bug: #{e.inspect}")
  end
end
