require 'sanatio/usage_error'

module Sanatio
  class ClassValidator
    attr_accessor :reason

    def initialize
      @skip_test = Proc.new { false }
    end

    def is(&validation_block)
      unless block_given?
        raise UsageError.new("self")
      end

      @validation_block = validation_block
      self
    end

    def skip_if(&skip_test)
      @skip_test = skip_test
      self
    end

    def skip?(object)
      object.instance_eval(&@skip_test)
    end

    def valid?(object)
      object.instance_eval(&@validation_block)
    end
  end
end
