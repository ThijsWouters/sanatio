module Sanatio
  module BlockValidator
    def is(&validation_block)
      unless block_given?
        raise UsageError.new(target)
      end

      @validation_block = validation_block
      self
    end

    def valid?(object)
      evaluate(object, @validation_block)
    end
  end
end
