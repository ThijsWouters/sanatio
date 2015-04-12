require 'sanatio/usage_error'

module Sanatio
  module Skippable
    def skip_if(&skip_test)
      raise UsageError.new("You need to give a block to #skip_if.") unless block_given?
      @skip_test = skip_test
      self
    end

    def skip_test
      @skip_test ||= Proc.new { false }
    end

    def skip?(object)
      evaluate(object, skip_test)
    end
  end
end
