require 'sanatio/built-in/support/compare'

module Sanatio
  module BuiltIn
    class LessThan < Compare
      def initialize(value)
        super(value, :<)
      end

      def reason
        :greater_than_or_equal_to
      end
    end
  end
end
