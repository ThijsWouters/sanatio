require 'minitest_helper'
require 'sanatio/built-in/either'

class TestEither < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(first_name, last_name)
        @first_name = first_name
        @last_name = last_name
      end

      attr_reader :first_name, :last_name

      ensure_that(self).is Either, :first_name, :last_name, Present
    end
  end

  def test_fails_when_both_fields_are_nil
    refute_valid(person_class.new(nil, nil), :reason => :neither, :params => [ :first_name, :last_name ])
  end

  def test_fails_when_both_fields_are_empty
    refute_valid(person_class.new('', ''), :reason => :neither, :params => [ :first_name, :last_name ])
  end

  def test_fails_when_both_fields_are_filled_in
    refute_valid(person_class.new('Test', 'Testington'), :reason => :both, :params => [ :first_name, :last_name ])
  end

  def test_passes_when_first_parameter_is_not_nil
    assert_valid(person_class.new('Test', nil))
  end

  def test_passes_when_second_parameter_is_not_nil
    assert_valid(person_class.new(nil, 'Testington'))
  end
end
