module Sanatio
  module BuiltIn
    class GreaterThanOrEqualTo
      def initialize(value)
        @value = value
      end

      def skip?(object)
        !object.respond_to?(:>=)
      end

      def valid?(object)
        object >= @value
      end

      def reason
        :less_than
      end

      def params
        [@value]
      end
    end
  end
end
