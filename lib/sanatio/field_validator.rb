require 'sanatio/usage_error'

module Sanatio
  class FieldValidator
    attr_reader :field
    attr_accessor :reason

    def initialize(field)
      @field = field
      @skip_test = Proc.new { false }
    end

    def is(&validation_block)
      unless block_given?
        raise UsageError.new(":#{field}")
      end

      @validation_block = validation_block
      self
    end

    def skip_if(&skip_test)
      @skip_test = skip_test
      self
    end

    def skip?(object)
      object.send(@field).instance_eval &@skip_test
    end

    def valid?(object)
      object.send(@field).instance_eval &@validation_block
    end
  end
end
