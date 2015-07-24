module Sanatio
  module BuiltIn
    class Compare
      def initialize(value, method)
        @value = value
        @method = method
      end

      def params
        [@value]
      end

      def skip?(object)
        return true unless object.respond_to?(@method)

        object.send(@method, @value)
        false
      rescue ArgumentError
        true
      end

      def valid?(object)
        object.send(@method, @value)
      end
    end
  end
end
