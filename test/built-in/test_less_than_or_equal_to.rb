require 'minitest_helper'

class Test < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(age)
        @age = age
      end

      attr_reader :age

      ensure_that(:age).is LessThanOrEqualTo, 18
    end
  end

  def test_fails_when_greater_than_value
    refute_valid(person_class.new(19), :field => :age, :reason => :greater_than, :params => [18])
  end

  def test_passes_when_equal_to_value
    assert_valid(person_class.new(18))
  end

  def test_passes_when_less_than_value
    assert_valid(person_class.new(17))
  end

  def test_passes_when_not_responds_to_less_than_or_equal_to
    assert_valid(person_class.new(Object.new))
  end
end
