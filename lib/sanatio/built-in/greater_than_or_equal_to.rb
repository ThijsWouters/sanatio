require 'sanatio/built-in/support/compare'

module Sanatio
  module BuiltIn
    class GreaterThanOrEqualTo < Compare
      def initialize(value)
        super(value, :>=)
      end

      def reason(_)
        :less_than
      end
    end
  end
end
