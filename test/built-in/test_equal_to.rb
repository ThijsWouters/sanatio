require 'minitest_helper'

class TestEqualTo < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(age)
        @age = age
      end

      attr_reader :age

      ensure_that(:age).is EqualTo, 18
    end
  end

  def test_fails_when_not_equal
    refute_valid(person_class.new(16), :field => :age, :reason => :not_equal_to, :params => [18])
  end

  def test_succeeds_when_equal
    assert_valid(person_class.new(18))
  end
end
