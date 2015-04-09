class Sanatio::ClassValidator
  attr_accessor :reason

  def initialize
  end

  def is(&validation_block)
    @validation_block = validation_block
    self
  end

  def valid?(object)
    object.instance_eval(&@validation_block)
  end
end
