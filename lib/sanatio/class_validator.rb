require 'sanatio/usage_error'
require 'sanatio/skippable'

module Sanatio
  class ClassValidator
    include Skippable

    attr_accessor :reason

    def is(&validation_block)
      unless block_given?
        raise UsageError.new("self")
      end

      @validation_block = validation_block
      self
    end

    def valid?(object)
      evaluate(object, @validation_block)
    end

    private
    def evaluate(object, block)
      object.instance_eval(&block)
    end
  end
end
