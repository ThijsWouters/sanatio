module Sanatio
  class UsageError < StandardError
    def initialize(target)
      super("You need to give a block to #is. The correct usage is:\nensure_that(#{target}).is { validation_test }")
    end
  end
end
