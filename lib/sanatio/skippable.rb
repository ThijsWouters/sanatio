module Sanatio
  module Skippable
    def skip_if(&skip_test)
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
