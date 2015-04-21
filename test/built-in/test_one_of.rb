require 'minitest_helper'

class TestOneOf < Minitest::Test
  def person_class
    Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(:name).is OneOf, 'Santa', 'Easter Bunny'
    end
  end

  def test_fails_when_not_one_of_the_values
    refute_valid(person_class.new('Test Testington'), :field => :name, :reason => :not_one_of, :params => ['Santa', 'Easter Bunny'])
  end

  def test_passes_when_one_of_the_values
    assert_valid(person_class.new('Santa'))
    assert_valid(person_class.new('Easter Bunny'))
  end

  def test_fails_when_nil
    refute_valid(person_class.new(nil), :field => :name, :reason => :not_one_of, :params => ['Santa', 'Easter Bunny'])
  end

  def test_can_be_skipped
    skipping_person = Class.new do
      include Sanatio

      def initialize(name)
        @name = name
      end

      attr_reader :name

      ensure_that(:name).is(OneOf, 'Santa', 'Easter Bunny').skip_if { nil? }
    end

    assert_valid(skipping_person.new(nil))
  end
end
