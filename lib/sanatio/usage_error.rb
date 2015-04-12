module Sanatio
  class UsageError < StandardError
    def initialize(message = "You need to give a block to #is.")
      super(message)
    end
  end
end
