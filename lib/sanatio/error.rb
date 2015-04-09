class Sanatio::Error
  extend Forwardable

  def_delegators :@validation, :field, :reason

  def initialize(validation)
    @validation = validation
  end
end
