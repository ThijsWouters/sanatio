require 'sanatio/validator_factory'

module Sanatio
  class FieldValidator
    include ValidatorFactory

    attr_reader :field

    def initialize(field)
      @field = field
    end

    def reason
      @validator.reason
    end

    def valid?(object)
      @validator.valid?(object.send(@field))
    end

    def skip?(object)
      @validator.skip?(object.send(@field))
    end
  end
end
