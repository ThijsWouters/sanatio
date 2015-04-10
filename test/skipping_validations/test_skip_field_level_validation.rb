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
    refute(person_class.new("").valid?)
  end

  def test_the_validation_is_skipped
    assert(person_class.new(nil).valid?)
  end
end
