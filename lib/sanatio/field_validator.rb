require 'sanatio/usage_error'
require 'sanatio/skippable'

module Sanatio
  class FieldValidator
    include Skippable

    attr_reader :field
    attr_accessor :reason

    def initialize(field)
      @field = field
    end

    def is(&validation_block)
      unless block_given?
        raise UsageError.new(":#{field}")
      end

      @validation_block = validation_block
      self
    end

    def valid?(object)
      evaluate(object, @validation_block)
    end

    private
    def evaluate(object, test)
      object.send(@field).instance_eval &test
    end
  end
end
