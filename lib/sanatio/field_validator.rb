require 'sanatio/usage_error'
require 'sanatio/skippable'
require 'sanatio/block_validator'

module Sanatio
  class FieldValidator
    include Skippable
    include BlockValidator

    attr_reader :field
    attr_accessor :reason

    def initialize(field)
      @field = field
    end

    private
    def evaluate(object, test)
      object.send(@field).instance_eval &test
    end
  end
end
