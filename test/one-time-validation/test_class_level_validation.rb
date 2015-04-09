require 'minitest_helper'

class TestTestClassLevelValidation < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(self).is { !name.nil? }.reason = :name_not_nil
    end
  end

  def test_validation_fails
    person = person_class.new(nil)

    refute(person.valid?, "The person should not be valid")

    assert_equal(1, person.errors.length, "I expected one error")

    error = person.errors.first
    assert_equal(:name_not_nil, error.reason, "The reason should be :name_not_nil")
  end

  def test_validation_passes
    person = person_class.new("Test Testington")

    assert(person.valid?, "The person should be valid")

    assert_empty(person.errors, "I expected no errors")
  end
end
