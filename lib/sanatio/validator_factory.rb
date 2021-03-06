require 'sanatio/block_validator'
require 'sanatio/usage_error'

module Sanatio
  module ValidatorFactory
    def is(validator = nil, *params, &validation_block)
      if validator
        @validator = validator.new(*params)
      else
        raise UsageError.new("You need to give a block to #is.") unless block_given?
        @validator = BlockValidator.new(validation_block)
      end
    end
  end
end
