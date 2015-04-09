require 'minitest_helper'

class TestFieldLevelValidation < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(:name).is { !nil? }.reason = :not_nil
    end
  end

  def test_failing_validation
    person = person_class.new(nil)

    refute(person.valid?, "The person should be invalid")

    assert_equal(1, person.errors.length, "I expected one error")

    error = person.errors.first
    assert_equal(:name, error.field, "The field should be :name")
    assert_equal(:not_nil, error.reason, "The reason should be :not_nil")
  end

  def test_succeeding_validation
    person = person_class.new("Test Testington")

    assert(person.valid?, "The person should be valid")

    assert_empty(person.errors, "I expected no errors")
  end
end
