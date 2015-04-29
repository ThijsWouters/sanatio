require 'minitest_helper'

class TestValid < Minitest::Test
  def address_class
    Class.new do
      include Sanatio

      def initialize(street)
        @street = street
      end

      attr_reader :street

      ensure_that(:street).is Present
    end
  end

  def person_class
    Class.new do
      include Sanatio

      def initialize(address)
        @address = address
      end

      attr_reader :address

      ensure_that(:address).is Valid
    end
  end

  def test_fails_if_address_is_invalid
    refute_valid(person_class.new(address_class.new(nil)), :field => :address, :reason => :invalid)
  end

  def test_passes_if_address_is_valid
    assert_valid(person_class.new(address_class.new("Alleystreet")))
  end

  def test_passes_if_address_does_not_respond_to_valid?
    assert_valid(person_class.new(Object.new))
  end
end
