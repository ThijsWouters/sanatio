module Sanatio
  module BuiltIn
    class Matching
      def initialize(regex)
        @regex = regex
      end

      def skip?(value)
        !value.respond_to?(:to_str)
      end

      def valid?(value)
        @regex.match(value)
      end

      def reason
        :no_match
      end

      def params
        [@regex]
      end
    end
  end
end

