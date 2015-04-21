module Sanatio
  module BuiltIn
    class OneOf
      def initialize(*values)
        @values = values
      end

      def skip?(object)
      end

      def valid?(object)
        @values.include?(object)
      end

      def reason
        :not_one_of
      end

      def params
        @values
      end
    end
  end
end
