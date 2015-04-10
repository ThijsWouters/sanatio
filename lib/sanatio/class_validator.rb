require 'sanatio/usage_error'
require 'sanatio/skippable'
require 'sanatio/block_validator'

module Sanatio
  class ClassValidator
    include Skippable
    include BlockValidator

    attr_accessor :reason

    private
    def evaluate(object, block)
      object.instance_eval(&block)
    end
  end
end
