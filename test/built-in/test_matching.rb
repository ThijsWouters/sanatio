require 'minitest_helper'

class TestMatching < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(:name).is Matching, /Test/
    end
  end

  def test_fails_when_value_does_not_match
    refute_valid(person_class.new('No Match'), :field => :name, :reason => :no_match, :params => [/Test/])
  end

  def test_passes_when_value_matches
    assert_valid(person_class.new('Test'))
  end

  def test_passes_when_value_cannot_be_matched
    assert_valid(person_class.new(Object.new))
  end
end
