require 'minitest_helper'

class TestFieldLevelValidation < Minitest::Test
  def test_failing_validation
    person_class = Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(:name).is { !nil? }.reason = :not_nil
    end

    person = person_class.new(nil)

    refute(person.valid?, "Person should be invalid")

    assert_equal(1, person.errors.length, "I expected one error")

    error = person.errors.first
    assert_equal(:name, error.field, "The field should be :name")
    assert_equal(:not_nil, error.reason, "The reason should be :not_nil")
  end
end
