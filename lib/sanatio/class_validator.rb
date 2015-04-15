require 'sanatio/validator_factory'
require 'sanatio/class_error'

module Sanatio
  class ClassValidator
    include ValidatorFactory

    def reason
      @validator.reason
    end

    def valid?(object)
      @validator.valid?(object)
    end

    def skip?(object)
      @validator.skip?(object)
    end

    def error
      ClassError.new(self)
    end
  end
end
