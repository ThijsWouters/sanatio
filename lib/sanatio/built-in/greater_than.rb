require 'sanatio/built-in/support/compare'

module Sanatio
  module BuiltIn
    class GreaterThan < Compare
      def initialize(value)
        super(value, :>)
      end

      def reason
        :less_than_or_equal_to
      end
    end
  end
end
