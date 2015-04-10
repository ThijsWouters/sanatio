require 'sanatio/usage_error'

module Sanatio
  class ClassValidator
    attr_accessor :reason

    def initialize
    end

    def is(&validation_block)
      unless block_given?
        raise UsageError.new("self")
      end

      @validation_block = validation_block
      self
    end

    def valid?(object)
      object.instance_eval(&@validation_block)
    end
  end
end
