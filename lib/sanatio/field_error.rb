require 'forwardable'

module Sanatio
  class FieldError
    extend Forwardable

    def_delegators :@validation, :field, :reason

    def initialize(validation)
      @validation = validation
    end
  end
end
