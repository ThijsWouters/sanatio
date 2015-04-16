require 'minitest_helper'

class TestGreaterThanOrEqualTo < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      attr_reader :age

      def initialize(age)
        @age = age
      end

      ensure_that(:age).is GreaterThanOrEqualTo, 18
    end
  end

  def test_fails_when_less_than_the_given_value
    refute_valid(person_class.new(17), {field: :age, reason: :less_than, params: [18]})
  end

  def test_passes_when_equal_to_the_given_value
    assert_valid(person_class.new(18))
  end

  def test_passes_when_greater_than_the_given_value
    assert_valid(person_class.new(19))
  end

  def test_passes_when_value_does_not_respond_to_greater_than_or_equal_to
    assert_valid(person_class.new(Object.new))
  end
end
