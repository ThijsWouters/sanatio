module Sanatio
  class UsageError < StandardError
    def initialize
      super("You need to give a block to #is.")
    end
  end
end
