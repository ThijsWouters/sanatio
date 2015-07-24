require 'sanatio/skippable'

module Sanatio
  class BlockValidator
    include Skippable

    def initialize(validation_block)
      @validation_block = validation_block
    end

    def valid?(object)
      object.instance_eval(&@validation_block)
    end

    def reason=(reason)
      @reason = reason
    end

    def reason(object)
      @reason
    end
  end
end

