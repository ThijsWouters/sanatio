require 'minitest_helper'

class TestSkipFieldLevelValidation < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(:name).is { !empty? }.skip_if { nil? }
    end
  end

  def test_the_validation_is_not_skipped
    refute_valid(person_class.new(""), :field => :name)
  end

  def test_the_validation_is_skipped
    assert_valid(person_class.new(nil))
  end
end
