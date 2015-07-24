require 'sanatio/skippable'

module Sanatio
  module BuiltIn
    class OneOf
      include Skippable

      def initialize(*values)
        @values = values
      end

      def valid?(object)
        @values.include?(object)
      end

      def reason(_)
        :not_one_of
      end

      def params
        @values
      end
    end
  end
end
