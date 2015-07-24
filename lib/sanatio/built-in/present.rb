module Sanatio
  module BuiltIn
    class Present
      def skip?(_)
      end

      def valid?(object)
        !object.nil? && (!object.respond_to?(:empty?) || !object.empty?)
      end

      def reason(_)
        :not_present
      end
    end
  end
end
