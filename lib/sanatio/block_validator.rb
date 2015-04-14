require 'sanatio/skippable'

module Sanatio
  class BlockValidator
    include Skippable

    attr_accessor :reason

    def initialize(validation_block)
      @validation_block = validation_block
    end

    def valid?(object)
      object.instance_eval(&@validation_block)
    end
  end
end

