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
        !object.respond_to?(@method)
      end

      def valid?(object)
        object.send(@method, @value)
      end
    end
  end
end
