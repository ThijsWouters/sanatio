module Sanatio
  module BuiltIn
    class Valid
      def skip?(object)
        !object.respond_to?(:valid?)
      end

      def valid?(object)
        object.valid?
      end

      def reason(_)
        :invalid
      end
    end
  end
end
