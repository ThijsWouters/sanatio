require 'sanatio/validator_factory'

module Sanatio
  class ClassValidator
    include ValidatorFactory

    Error = Struct.new(:reason, :params)

    def valid?(object)
      @validator.valid?(object)
    end

    def skip?(object)
      @validator.skip?(object)
    end

    def error
      Error.new(@validator.reason, params)
    end

    private
    def params
      if @validator.respond_to?(:params)
        @validator.params
      else
        []
      end
    end
  end
end
