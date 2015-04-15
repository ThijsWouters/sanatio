require 'minitest_helper'

class TestClassLevelValidation < Minitest::Test
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
    refute_valid(person_class.new(nil), reason: :name_not_nil)
  end

  def test_validation_passes
    assert_valid(person_class.new("Test Testington"))
  end
end
