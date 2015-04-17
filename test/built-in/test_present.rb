require 'minitest_helper'

class TestPresent < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(:name).is Present
    end
  end

  def test_fails_when_value_is_nil
    refute_valid(person_class.new(nil), :field => :name, :reason => :not_present)
  end

  def test_fails_when_value_is_empty
    refute_valid(person_class.new(''), :field => :name, :reason => :not_present)
  end

  def test_succeeds_when_value_is_filled_in
    assert_valid(person_class.new('Test Testington'))
  end

  def test_succeeds_when_value_is_filled_in_but_does_not_respond_to_empty?
    assert_valid(person_class.new(Object.new))
  end
end
