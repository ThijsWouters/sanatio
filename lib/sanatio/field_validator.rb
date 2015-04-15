require 'sanatio/validator_factory'

module Sanatio
  class FieldValidator
    include ValidatorFactory

    Error = Struct.new(:field, :reason, :params)

    def initialize(field)
      @field = field
    end

    def valid?(object)
      @validator.valid?(object.send(@field))
    end

    def skip?(object)
      @validator.skip?(object.send(@field))
    end

    def error
      Error.new(@field, @validator.reason, [])
    end
  end
end
