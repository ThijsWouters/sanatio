module Sanatio
  module BuiltIn
    class GreaterThan
      def initialize(value)
        @value = value
      end

      def skip?(object)
        !object.respond_to?(:>)
      end

      def valid?(object)
        object > @value
      end

      def reason
        :less_than_or_equal_to
      end

      def params
        [@value]
      end
    end
  end
end
