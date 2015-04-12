module Sanatio
  module BlockValidator
    def is(&validation_block)
      raise UsageError.new("You need to give a block to #is.") unless block_given?
      @validation_block = validation_block
      self
    end

    def valid?(object)
      evaluate(object, @validation_block)
    end
  end
end
