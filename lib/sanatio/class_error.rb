module Sanatio
  class ClassError
    extend Forwardable

    def_delegators :@validation, :reason

    def initialize(validation)
      @validation = validation
    end
  end
end
