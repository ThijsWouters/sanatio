require 'sanatio/built-in/support/compare'

module Sanatio
  module BuiltIn
    class LessThanOrEqualTo < Compare
      def initialize(value)
        super(value, :<=)
      end

      def reason(_)
        :greater_than
      end
    end
  end
end
