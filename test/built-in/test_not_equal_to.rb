require 'minitest_helper'

class TestNotEqualTo < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(age)
        @age = age
      end

      attr_reader :age

      ensure_that(:age).is NotEqualTo, 18
    end
  end

  def test_fails_when_equal
    refute_valid(person_class.new(18), :field => :age, :reason => :equal_to, :params => [18])
  end

  def test_passes_when_not_equal
    assert_valid(person_class.new(24))
  end
end
