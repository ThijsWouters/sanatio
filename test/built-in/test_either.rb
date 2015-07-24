require 'minitest_helper'

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

  def account_class
    Class.new do
      include Sanatio

      def initialize(inflow, outflow)
        @inflow = inflow
        @outflow = outflow
      end

      attr_reader :inflow, :outflow

      ensure_that(self).is Either, :inflow, :outflow, GreaterThan, 0
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

  def test_fails_when_both_account_fields_are_negative
    refute_valid(account_class.new(-1, -1), :reason => :neither, :params => [ :inflow, :outflow ])
  end

  def test_passes_when_account_fields_are_nil
    assert_valid(account_class.new(nil, nil))
  end

  def test_passes_when_account_first_field_is_nil_and_second_valid
    assert_valid(account_class.new(nil, 1))
  end

  def test_passes_when_account_second_field_is_nil_and_first_valid
    assert_valid(account_class.new(1, nil))
  end

  def test_passes_when_account_first_field_is_nil_and_second_invalid
    assert_valid(account_class.new(nil, -1))
  end

  def test_passes_when_account_second_field_is_nil_and_first_invalid
    assert_valid(account_class.new(-1, nil))
  end
end
