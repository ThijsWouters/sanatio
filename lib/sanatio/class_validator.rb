require 'sanatio/validator_factory'

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
  end
end
