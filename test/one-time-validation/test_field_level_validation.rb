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
    refute_valid(person_class.new(nil), field: :name, reason: :not_nil)
  end

  def test_succeeding_validation
    assert_valid(person_class.new("Test Testington"))
  end
end
